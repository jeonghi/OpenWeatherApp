//
//  HourWeather.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/1/24.
//

import Foundation

struct HourWeather: Hashable {
  
  var date: Date
  var condition: String
  var symbolName: String
  var temperature: Measurement<UnitTemperature>
}
