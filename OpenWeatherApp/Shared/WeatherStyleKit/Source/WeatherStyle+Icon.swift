//
//  WeatherStyle+Icon.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/1/24.
//

import SwiftUI

extension WeatherStyle.Icon {
  
  static let clearSky = Image("01d")
  static let fewClouds = Image("02d")
  static let scatteredClouds = Image("03d")
  static let brokenClouds = Image("04d")
  static let showerRain = Image("09d")
  static let rain = Image("10d")
  static let thunderstorm = Image("11d")
  static let snow = Image("13d")
  static let mist = Image("50d")
  static let unknown = Image(systemName: "questionmark.circle.fill")
  
  static func image(for symbolName: String) -> Image {
    
    let prefix = String(symbolName.prefix(2))
    
    let icon = WeatherStyle.Icon.self
    switch prefix {
    case "01": return icon.clearSky
    case "02": return icon.fewClouds
    case "03": return icon.scatteredClouds
    case "04": return icon.brokenClouds
    case "09": return icon.showerRain
    case "10": return icon.rain
    case "11": return icon.thunderstorm
    case "13": return icon.snow
    case "50": return icon.mist
    default: return icon.unknown
    }
  }
}
