//
//  CityDescriptionView.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/1/24.
//

import SwiftUI

struct CityDescriptionView {
  let city: City?
  var currWeather: CurrentWeather?
  var dayWeather: DayWeather?
}

private enum Metric {
  static let spacing: CGFloat = 15
}

extension CityDescriptionView: View {
  var body: some View {
    VStack(alignment: .center, spacing: Metric.spacing){
      
      if let city {
        Text("\(city.name)")
          .font(.largeTitle)
          .ex.vTop()
      }
      
      if let currWeather {
        Text("\(currWeather.temperature.formatted())")
          .font(.title3)
        Text("\(currWeather.condition)")
      }
      
      if let dayWeather {
        Text("최고: \(dayWeather.highTemperature.formatted()) | 최소: \(dayWeather.lowTemperature.formatted())")
      }
    } //: VStack
    .shadow(radius: 5)
  }
}
