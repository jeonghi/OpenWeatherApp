//
//  CityEntity+Mapper.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/5/24.
//

import Foundation

extension CityEntity {
  
  func toCityModel() -> City {
    .init(
      id: self.id,
      name: self.name,
      country: self.country,
      coordinate: .init(
        latitude: self.coord.lat,
        longitude: self.coord.lon
      )
    )
  }
}
