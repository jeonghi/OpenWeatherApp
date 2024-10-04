//
//  CityDataSource.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/1/24.
//

import Foundation

protocol CityDataSourceType: AnyObject {
  func fetchAllCities() async throws -> [CityEntity]
}

final class CityDataSourceImpl: CityDataSourceType {
  
  static let shared: CityDataSourceType = CityDataSourceImpl()
  
  private init() {}
  
  private let resource = "citylist.json"
  
  func fetchAllCities() async throws -> [CityEntity] {
    try await loadCities()
  }
  
  private func loadCities() async throws -> [CityEntity] {
    guard let url = Bundle.main.url(forResource: resource, withExtension: nil) else {
      print("File not found in bundle: \(resource)")
      throw DataSourceError.notFound(bundle: .main)
    }
    
    do {
      let data = try Data(contentsOf: url)
      let decodedData = try JSONDecoder().decode([CityEntity].self, from: data)
      return decodedData
    } catch let error as DecodingError {
      print("Decoding error: \(error)")
      throw DataSourceError.decodingFailed
    } catch {
      print("Failed to load data from bundle: \(error)")
      throw DataSourceError.unableToRead
    }
  }
}

final class CityDataSourceMock: CityDataSourceType {
  func fetchAllCities() async throws -> [CityEntity] {
    []
  }
}

enum DataSourceError: Error {
  case notFound(bundle: Bundle) // 파일 경로를 찾을 수 없을 때 발생
  case unableToRead // 파일을 읽을 수 없을 때 발생
  case decodingFailed // 데이터를 디코딩할 수 없을 때 발생
}

extension DataSourceError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .notFound(let bundle):
      return "해당 파일을 \(bundle)번들에서 찾을 수 없습니다."
    case .unableToRead:
      return "파일을 읽을 수 없습니다."
    case .decodingFailed:
      return "파일을 디코딩하는 데 실패했습니다."
    }
  }
}
