//
//  City.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/1/24.
//

import Foundation

struct City: Codable, Hashable {
  let id: Int
  let name: String // 도시 이름
  let country: String // 나라 (국가 코드)
  let coordinate: CityCoordinate // 도시 좌표
}

struct CityCoordinate: Codable, Hashable {
  let latitude: Double // 위도
  let longitude: Double // 경도
}
