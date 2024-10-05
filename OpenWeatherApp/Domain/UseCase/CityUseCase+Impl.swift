//
//  CityUseCase+Impl.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/5/24.
//

import Foundation

final class CityUseCaseImpl: CityUseCaseType {
  
  static let shared: CityUseCaseType = CityUseCaseImpl()
  
  // MARK: Dependencies
  private let weatherRepository: CityWeatherRepositoryType = CityWeatherRepositoryImpl.shared
  
  // MARK: Constructor
  private init() {}
  private var lastFetchTime: Date? // 마지막 데이터 fetch 시간
  
  // MARK: Utils
  func fetchCityWeather(for city: City) async throws -> Weather {
    return try await weatherRepository.fetchWeather(
      for: .init(
        latitude: city.coordinate.latitude,
        longitude: city.coordinate.longitude
      )
    )
  }
  
  func fetchCityList(page: Int = 1, pageSize: Int = 20, query: String? = nil) async throws -> [City] {
    let fetchResult = try await weatherRepository.fetchCityList(
      page: page,
      pageSize: pageSize,
      query: query
    )
    return fetchResult
  }
  
  func loadLatestCity() async -> City {
    return .default
  }
}
