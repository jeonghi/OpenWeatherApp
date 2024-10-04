//
//  Forecast.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/1/24.
//

import Foundation

struct Forecast<Element>: RandomAccessCollection, Hashable where Element: Equatable, Element: Hashable {
  
  /// The forecast index.
  typealias Index = Int
  
  /// The forecast collection.
  var forecast: [Element]
  
  /// The forecast start index.
  var startIndex: Index { forecast.startIndex }
  
  /// The forecast end index.
  var endIndex: Index { forecast.endIndex }
  
  /// The forecast element at the provided index.
  subscript(position: Index) -> Element {
    forecast[position]
  }
  
  static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.forecast == rhs.forecast
  }
  
  typealias Indices = Range<Forecast<Element>.Index>
  typealias Iterator = IndexingIterator<Forecast<Element>>
  typealias SubSequence = Slice<Forecast<Element>>
}

extension Forecast where Element == HourWeather {
  
  /// 시간 간격과 날짜 범위에 따라 필터링된 HourWeather 반환
  func filteredForecast(from startDate: Date, to endDate: Date, interval: Int) -> Forecast<HourWeather> {
    // 필터링된 HourWeather 배열 생성
    let filteredForecast = forecast.filter { hourWeather in
      let hourDate = hourWeather.date
      return hourDate >= startDate && hourDate <= endDate
    }
    
    // 시간 간격에 맞춰 필터링된 결과 반환
    let result = filteredForecast.enumerated().filter { index, _ in
      index % interval == 0
    }.map { $0.element }
    
    return Forecast(forecast: result)
  }
}

extension Forecast where Element == DayWeather {
  
  /// 날짜 범위에 따라 필터링된 DayWeather 반환
  func filteredForecast(from startDate: Date, to endDate: Date) -> Forecast<DayWeather> {
    
    // 필터링된 DayWeather 배열 생성
    let filteredForecast = forecast.filter { dayWeather in
      let dayDate = dayWeather.date
      return dayDate >= startDate && dayDate <= endDate
    }
    
    return Forecast(forecast: filteredForecast)
  }
}

