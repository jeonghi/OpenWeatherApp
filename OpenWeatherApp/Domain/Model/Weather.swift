//
//  Weather.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/1/24.
//

import Foundation
import CoreLocation

struct Weather {
  /// 현재 일기예보
  var currentWeather: CurrentWeather
  /// 날짜별 일기예보
  var dailyForecast: Forecast<DayWeather>
  /// 시간대별 일기예보
  var hourlyForecast: Forecast<HourWeather>
}

struct DayWeather: Hashable {
  
  var date: Date
  var condition: String
  var symbolName: String
  
  var highTemperature: Measurement<UnitTemperature>
  var highTemperatureTime: Date?
  
  var lowTemperature: Measurement<UnitTemperature>
  var lowTemperatureTime: Date?
}
