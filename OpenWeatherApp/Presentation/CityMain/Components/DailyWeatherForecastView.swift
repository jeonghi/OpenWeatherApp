//
//  DailyWeatherForecaseView.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/1/24.
//

import SwiftUI

struct DailyWeatherForecastView {
  
  private let forecast: Forecast<DayWeather>
  
  init(_ forecast: Forecast<DayWeather>) {
    self.forecast = forecast
  }
}

private enum Metric {
  static let spacing: CGFloat = 10
  static let weatherIconHeight: CGFloat = 30
}

extension DailyWeatherForecastView: View {
  var body: some View {
    LazyVStack(spacing: Metric.spacing) {
      scrollContentView()
    } //: LazyHStack
  }
}

private extension DailyWeatherForecastView {
  func scrollContentView() -> some View {
    ForEach(forecast, id: \.self) { item in
      scrollContentItemView(for: item)
    } //: ForEach
  }
  
  func scrollContentItemView(for item: DayWeather) -> some View {
    HStack(alignment: .center, spacing: Metric.spacing) {
      Text(item.date.asFormattedDayOfWeekString() ?? "")
        .lineLimit(1)
        .multilineTextAlignment(.leading)
        .frame(width: 40, alignment: .leading)
      WeatherStyle.Icon.image(for: item.symbolName)
        .resizable()
        .scaledToFit()
        .frame(height: Metric.weatherIconHeight)
        .ex.hCenter()
      Text("최소:\(item.lowTemperature.formatted()) 최대:\(item.highTemperature.formatted())")
        .lineLimit(1)
        .frame(width: 180, alignment: .trailing)
    }
  }
}
