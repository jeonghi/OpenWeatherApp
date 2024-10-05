//
//  City+dummy.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/5/24.
//

import Foundation

extension City {
  static let dummyData = City(
    id: 1839726,
    name: "Asan",
    country: "KR",
    coordinate: .dummyData
  )
  
  static let `default` = dummyData
}

extension CityCoordinate {
  static let dummyData = CityCoordinate(
    latitude: 36.783611,
    longitude: 127.004173
  )
}
