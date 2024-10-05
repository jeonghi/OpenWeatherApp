//
//  CurrWeather.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/1/24.
//

import Foundation

struct CurrentWeather {
  
  /// 날씨 정보 날짜 ✅
  var date: Date
  
  /// 날씨 상태 ✅
  var condition: String
  
  /// 심볼 이름 ✅
  var symbolName: String
  
  /// 구름 량 ✅
  var cloudCover: Double
  
  /// 습도 ✅
  var humidity: Double
  
  /// 기압 ✅
  var pressure: Measurement<UnitPressure>
  
  /// 기온 ✅
  var temperature: Measurement<UnitTemperature>
  
  /// 풍속 ✅
  var windSpeed: Measurement<UnitSpeed>
  
  /// 메타데이터 ✅
  var metadata: WeatherMetadata
}
