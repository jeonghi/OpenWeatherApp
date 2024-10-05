//
//  CityWeatherRepository.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/5/24.
//

import Foundation
import CoreLocation

protocol CityWeatherRepositoryType: AnyObject {
  
  /// 저장소에서 도시 목록을 불러오는 메서드 (페이지네이션 적용)
  func fetchCityList(page: Int, pageSize: Int, query: String?) async throws -> [City]
  
  /// 저장소에서 도시 기후 정보를 불러오는 메서드
  func fetchWeather(for location: CLLocation) async throws -> Weather
}
