//
//  WeatherMetaData.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/1/24.
//

import Foundation
import CoreLocation

struct WeatherMetadata: Hashable {
  
  /// 날씨 데이터 요청 날짜
  var date: Date
  
  /// 날씨 데이터 말료 일짜
  var expirationDate: Date {
    date.addingTimeInterval(10 * 60)
  }
  
  /// 날씨 데이터
  var location: CLLocation
}
