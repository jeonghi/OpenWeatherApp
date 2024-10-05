//
//  CityRepository.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/1/24.
//

import Foundation
import CoreLocation


final class CityWeatherRepositoryImpl: CityWeatherRepositoryType {
  
  // MARK: Dependency
  private let cityDatasource: CityDataSourceType = CityDataSourceImpl.shared
  private let cityAPIClient = APIClient<WeatherAPI>()
  
  // MARK: singleton
  static let shared: CityWeatherRepositoryType = CityWeatherRepositoryImpl()
  
  // MARK: properties
  private var cachedCities: [CityEntity] = []
  
  @UserDefaultWrapper(key: "latestCity", defaultValue: City.default.toCityEntity())
  private(set) var latestCity: CityEntity
  
  // MARK: constructor
  private init() {}
  
  func fetchWeather(for location: CLLocation) async throws -> Weather {
    
    // 요청
    let requestDTO: GetCityWeatherInfoDTO.Request = try .init(
      location: .init(
        latitude: location.coordinate.latitude,
        longitude: location.coordinate.longitude
      )
    )
    
    // 응답값
    let responseDTO = try await cityAPIClient.request(
      .fetchWeatherInfo(params: requestDTO),
      GetCityWeatherInfoDTO.Response.self
    )
    
    return responseDTO.toWeather()
  }
  
  /// 페이지네이션과 쿼리 조건을 적용하여 도시 리스트를 가져오는 메서드
  func fetchCityList(page: Int = 1, pageSize: Int = 20, query: String? = nil) async throws -> [City] {
    
    // 캐싱된 데이터가 없으면 데이터를 로드하고 캐싱
    if cachedCities.isEmpty {
      cachedCities = try await cityDatasource.fetchAllCities()
    }
    
    let filteredCities: [CityEntity]
    
    if let query, !query.isEmpty {
      // 쿼리 조건이 있다면 해당 조건으로 데이터를 필터링
      filteredCities = cachedCities.filter {
        $0.name.lowercased().contains(query.lowercased())
      }
    } else {
      // 쿼리가 없다면 전체 데이터 사용
      filteredCities = cachedCities
    }
    
    // 시작 인덱스와 끝 인덱스를 계산하여 페이징 적용
    let startIndex = page * pageSize
    let endIndex = min(startIndex + pageSize, filteredCities.count)
    
    guard startIndex < filteredCities.count else {
      return [] // 요청한 페이지에 데이터가 없으면 빈 배열 반환
    }
    
    // CityEntity -> CityModel 변환하여 반환
    let pagedCities = Array(filteredCities[startIndex..<endIndex])
    return pagedCities.map { $0.toCityModel() }
  }
  
  func fetchLastCity() async -> City {
    latestCity.toCityModel()
  }
  
  func updateLastCity(_ city: City) async {
    self.latestCity = city.toCityEntity()
  }
}
