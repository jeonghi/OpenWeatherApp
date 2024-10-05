//
//  GetCityWeatherInfoDTO.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/1/24.
//

import Foundation


enum GetCityWeatherInfoDTO {
  
  struct Request: Encodable {
    
    let location: Location
    
    init(location: Location) {
      self.location = location
    }
    
    func encode(to encoder: any Encoder) throws {
      try location.encode(to: encoder)
    }
  }
  
  struct Response: Decodable {
    
    let location: Location
    let timezone: String
    let timezoneOffset: Int
    let current: CurrentWeather
    let hourly: [HourlyWeather]
    let daily: [DailyWeather]
    
    enum CodingKeys: String, CodingKey {
      case timezone
      case timezoneOffset = "timezone_offset"
      case current, hourly, daily
    }
    
    init(from decoder: any Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      
      self.timezone = try container.decode(String.self, forKey: .timezone)
      self.timezoneOffset = try container.decode(Int.self, forKey: .timezoneOffset)
      self.current = try container.decode(CurrentWeather.self, forKey: .current)
      self.hourly = try container.decode([HourlyWeather].self, forKey: .hourly)
      self.daily = try container.decode([DailyWeather].self, forKey: .daily)
      self.location = try Location(from: decoder)
    }
  }
}


// MARK: Location
extension GetCityWeatherInfoDTO {
  
  struct Location: Codable {
    
    enum LocationError: Error {
      case invalidLatitude
      case invalidLongitude
    }
    
    let latitude: Double
    let longitude: Double
    
    init(latitude: Double, longitude: Double) throws {
      guard latitude >= -90 && latitude <= 90 else {
        throw LocationError.invalidLatitude
      }
      
      guard longitude >= -180 && longitude <= 180 else {
        throw LocationError.invalidLongitude
      }
      
      self.latitude = latitude
      self.longitude = longitude
    }
    
    enum CodingKeys: String, CodingKey {
      case latitude = "lat"
      case longitude = "lon"
    }
    
    init(from decoder: any Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      self.latitude = try container.decode(Double.self, forKey: .latitude)
      self.longitude = try container.decode(Double.self, forKey: .longitude)
    }
    
    func encode(to encoder: any Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(self.latitude, forKey: .latitude)
      try container.encode(self.longitude, forKey: .longitude)
    }
  }
}

extension GetCityWeatherInfoDTO {
  
  struct CurrentWeather: Decodable {
    let date: TimeInterval
    let temp: Double // 온도 ✅
    let pressure: Int // 기압 ✅
    let humidity: Int // 습도 ✅
    let clouds: Int // 구름 ✅
    let windSpeed: Double // 바람 속도 ✅
    let weather: [WeatherDescription] // ✅
    
    enum CodingKeys: String, CodingKey {
      case date = "dt"
      case temp
      case pressure
      case humidity
      case clouds
      case windSpeed = "wind_speed"
      case weather
    }
    
    init(from decoder: any Decoder) throws {
      let container: KeyedDecodingContainer<CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
      self.date = try container.decode(TimeInterval.self, forKey: .date)
      self.temp = try container.decode(Double.self, forKey: .temp)
      self.pressure = try container.decode(Int.self, forKey: .pressure)
      self.humidity = try container.decode(Int.self, forKey: .humidity)
      self.clouds = try container.decode(Int.self, forKey: .clouds)
      self.windSpeed = try container.decode(Double.self, forKey: .windSpeed)
      self.weather = try container.decode([WeatherDescription].self, forKey: .weather)
    }
  }
  
  // 시간, 아이콘, 온도
  struct HourlyWeather: Decodable {
    let date: TimeInterval // ✅ 시간
    let temp: Double // ✅ 기온
    let weather: [WeatherDescription] // ✅ 아이콘
    
    enum CodingKeys: String, CodingKey {
      case date = "dt"
      case temp
      case weather
    }
    
    init(from decoder: any Decoder) throws {
      let container: KeyedDecodingContainer<CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
      self.date = try container.decode(TimeInterval.self, forKey: .date)
      self.temp = try container.decode(Double.self, forKey: .temp)
      self.weather = try container.decode([WeatherDescription].self, forKey: .weather)
    }
  }
  
  // 날짜, 최소, 최대, 아이콘
  struct DailyWeather: Decodable {
    let date: TimeInterval // 시간 ✅
    let temp: DailyTemperature // 온도
    let weather: [WeatherDescription] // 날씨 정보
    
    enum CodingKeys: String, CodingKey {
      case date = "dt"
      case temp
      case weather
    }
    
    init(from decoder: any Decoder) throws {
      let container: KeyedDecodingContainer<CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
      self.date = try container.decode(TimeInterval.self, forKey: .date)
      self.temp = try container.decode(DailyTemperature.self, forKey: .temp)
      self.weather = try container.decode([WeatherDescription].self, forKey: .weather)
    }
  }
  
  struct DailyTemperature: Decodable {
    let min: Double // ✅ 최소
    let max: Double // ✅ 최대
  }
  
  struct WeatherDescription: Decodable {
    let description: String // ✅ 날씨 정보(언어 적용됨)
    let icon: String // ✅ 날씨 아이콘 코드
  }
}
