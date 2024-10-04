//
//  HourlyWeatherView.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/1/24.
//

import SwiftUI

struct HourlyWeatherForecastView {
  
  private let forecast: Forecast<HourWeather>
  
  init(_ forecast: Forecast<HourWeather>) {
    self.forecast = forecast
  }
}

private enum Metric {
  static let spacing: CGFloat = 15
  static let horizontalSpacing: CGFloat = 10
  static let weatherIconHeight: CGFloat = 30
}

extension HourlyWeatherForecastView: View {
  
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      LazyHStack(spacing: Metric.horizontalSpacing) {
        scrollContentView()
      } //: LazyHStack
    } //: ScrollView
  }
}

extension HourlyWeatherForecastView {
  
  private func scrollContentView() -> some View {
    ForEach(forecast, id: \.self) { item in
      scrollContentItemView(for: item)
    }
  }
  
  private func scrollContentItemView(for item: HourWeather) -> some View {
    VStack(alignment: .center, spacing: Metric.spacing) {
      Text(item.date.asFormattedTimeString() ?? "")
      
      WeatherStyle.Icon.image(for: item.symbolName)
      .resizable()
      .scaledToFit()
      .frame(height: Metric.weatherIconHeight)
      
      Text(item.temperature.formatted())

        .bold()
    }
  }
}

#if(DEBUG)
#Preview {
  HourlyWeatherForecastView(
    Weather.dummyData.hourlyForecast
  )
}
#endif
