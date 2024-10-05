//
//  GetCityWeatherInfoDTO+Mapper.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/5/24.
//

import Foundation
import CoreLocation


// MARK: - Response -> Weather 변환 메서드
extension GetCityWeatherInfoDTO.Response {
  func toWeather() -> Weather {
    
    // 현재 날씨 매핑
    let currentWeather = CurrentWeather(
      date: self.current.date.toDate(),
      condition: self.current.weather.first?.description ?? "정보 없음",
      symbolName: self.current.weather.first?.icon ?? "unknown",
      cloudCover: Double(self.current.clouds) / 100.0,
      humidity: Double(self.current.humidity) / 100.0,
      pressure: Measurement(value: Double(self.current.pressure), unit: UnitPressure.hectopascals),
      temperature: Measurement(value: self.current.temp.asCelsius(), unit: UnitTemperature.celsius),
      windSpeed: Measurement(value: self.current.windSpeed, unit: UnitSpeed.metersPerSecond),
      metadata: WeatherMetadata(date: Date(), location: self.location.toCLLocation())
    )
    
    // 시간대별 날씨 예보 매핑
    let hourlyWeather = self.hourly.map { hourly in
      HourWeather(
        date: hourly.date.toDate(), // 타임존 오프셋을 고려하여 날짜 변환
        condition: hourly.weather.first?.description ?? "정보 없음",
        symbolName: hourly.weather.first?.icon ?? "unknown",
        temperature: Measurement(value: hourly.temp.asCelsius(), unit: UnitTemperature.celsius)
      )
    }
    
    let hourlyForecast = Forecast<HourWeather>(forecast: hourlyWeather)
    
    // 날짜별 날씨 예보 매핑
    let dailyWeather = self.daily.map { daily in
      DayWeather(
        date: daily.date.toDate(), // 타임존 오프셋을 고려하여 날짜 변환
        condition: daily.weather.first?.description ?? "정보 없음",
        symbolName: daily.weather.first?.icon ?? "unknown",
        highTemperature: Measurement(value: daily.temp.max.asCelsius(), unit: UnitTemperature.celsius),
        highTemperatureTime: nil, // 필요한 경우 적절히 설정
        lowTemperature: Measurement(value: daily.temp.min.asCelsius(), unit: UnitTemperature.celsius),
        lowTemperatureTime: nil // 필요한 경우 적절히 설정
      )
    }
    
    let dailyForecast = Forecast<DayWeather>(forecast: dailyWeather)
    
    // 최종 Weather 객체 생성
    return Weather(
      currentWeather: currentWeather,
      dailyForecast: dailyForecast,
      hourlyForecast: hourlyForecast
    )
  }
}

private extension TimeInterval {
  func toDate() -> Date {
    Date(timeIntervalSince1970: self)
  }
}

private extension Double {
  func asCelsius() -> Double {
    return Double(Int(self - 273.15))
  }
}


private extension GetCityWeatherInfoDTO.Location {
  func toCLLocation() -> CLLocation {
    return CLLocation(
      latitude: latitude,
      longitude: longitude
    )
  }
}
