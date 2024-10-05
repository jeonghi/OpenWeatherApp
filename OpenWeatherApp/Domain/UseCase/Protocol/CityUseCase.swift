//
//  CityUseCase.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/5/24.
//

import Foundation

protocol CityUseCaseType: AnyObject {
  
  /// 현재 도시의 기상 정보를 반환해주는 함수
  func fetchCityWeather(for city: City) async throws -> Weather
  
  /// 다음 페이지의 시작점과 페이지의 크기를 받아서 데이터와 마지막 페이지 여부를 리턴해주는 함수 ✅
  func fetchCityList(page: Int, pageSize: Int, query: String?) async throws -> [City]
  
  func loadLatestCity() async -> City
}
