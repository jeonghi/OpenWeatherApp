//
//  Weather+dummy.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/1/24.
//

import Foundation
import CoreLocation

extension Weather {
  
  
  // MARK: - 더미 데이터 생성 함수
  
  static func createDummyWeatherData() -> Weather {
    
    // 현재 날씨 데이터 생성
    let currentDate = Date()
    let currentWeather = CurrentWeather(
      date: currentDate,
      condition: "맑음",
      symbolName: "sun.max",
      cloudCover: 0.1,
      humidity: 0.65,
      pressure: Measurement(value: 1013, unit: UnitPressure.hectopascals),
      temperature: Measurement(value: 22, unit: UnitTemperature.celsius),
      windSpeed: Measurement(value: 5, unit: UnitSpeed.kilometersPerHour),
      metadata: WeatherMetadata(date: currentDate, location: CLLocation(latitude: 37.7749, longitude: -122.4194))
    )
    
    let calendar = Calendar.current

    
    // 일기 예보 데이터 생성 (예: 이틀치)
    let firstDayWeather = DayWeather(
      date: calendar.date(byAdding: .day, value: 0, to: currentDate)!,
      condition: "흐림",
      symbolName: "04d",
      highTemperature: Measurement(value: 25, unit: UnitTemperature.celsius),
      highTemperatureTime: calendar.date(byAdding: .hour, value: 14, to: currentDate),
      lowTemperature: Measurement(value: 15, unit: UnitTemperature.celsius),
      lowTemperatureTime: calendar.date(byAdding: .hour, value: 6, to: currentDate)
    )
    
    let secondDayWeather = DayWeather(
      date: calendar.date(byAdding: .day, value: 1, to: currentDate)!,
      condition: "비",
      symbolName: "04d",
      highTemperature: Measurement(value: 22, unit: UnitTemperature.celsius),
      highTemperatureTime: calendar.date(byAdding: .hour, value: 15, to: currentDate),
      lowTemperature: Measurement(value: 12, unit: UnitTemperature.celsius),
      lowTemperatureTime: calendar.date(byAdding: .hour, value: 6, to: currentDate)
    )
    
    // 일기 예보 생성
    let dailyForecast = Forecast<DayWeather>(forecast: [firstDayWeather, secondDayWeather])
    
    // 시간대별 일기 예보 데이터 생성 (더미 데이터 예시)
    let hourWeatherData: [HourWeather] = (0..<8).map { hour in
      HourWeather(
        date: calendar.date(byAdding: .hour, value: hour, to: currentDate)!,
        condition: "맑음",
        symbolName: "04d",
        temperature: Measurement(value: 20 + Double(hour), unit: UnitTemperature.celsius)
      )
    }
    
    let hourlyForecast = Forecast<HourWeather>(forecast: hourWeatherData)
    
    // 최종 날씨 데이터 객체 생성
    let weather = Weather(
      currentWeather: currentWeather,
      dailyForecast: dailyForecast,
      hourlyForecast: hourlyForecast
    )
    
    return weather
  }
  
  // MARK: - 더미 데이터 사용 예
  
  static var dummyData: Weather { createDummyWeatherData() }
}
