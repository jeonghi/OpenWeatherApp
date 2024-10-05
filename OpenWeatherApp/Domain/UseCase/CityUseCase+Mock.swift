//
//  CityUseCase+Mock.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/5/24.
//

import Foundation

final class CityUseCaseMock: CityUseCaseType {
  
  static let shared: CityUseCaseType = CityUseCaseMock()
  
  // MARK: Constructor
  private init() {}
  
  // MARK: Utils
  func fetchCityWeather(for city: City) async throws -> Weather{
    .dummyData
  }
  
  func fetchCityList(page: Int, pageSize: Int, query: String?) async throws -> [City] {
    [.dummyData]
  }
  
  func loadLatestCity() async -> City {
    return .default
  }
}
