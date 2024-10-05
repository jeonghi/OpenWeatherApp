//
//  CityEntity.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/1/24.
//

import Foundation

/// 영속성 계층에서 사용할 City 객체
struct CityEntity: Decodable {
  let id: Int
  let name: String // 도시 이름
  let country: String // 나라 (국가 코드)
  let coord: Coordinate
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case country
    case coord
  }

  struct Coordinate: Decodable {
    let lat: Double
    let lon: Double
  }
}
