//
//  CityWeatherRepository+Mock.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/5/24.
//

import Foundation
import CoreLocation

final class CityWeatherRepositoryMock: CityWeatherRepositoryType {
  
  // MARK: singleton
  static let shared: CityWeatherRepositoryType = CityWeatherRepositoryMock()
  
  // MARK: constructor
  private init() {}
  
  func fetchCityList(page: Int = 1, pageSize: Int = 20, query: String?) async throws -> [City] {
    [.dummyData, .dummyData]
  }
  
  func fetchWeather(for location: CLLocation) async throws -> Weather {
    .dummyData
  }
}

