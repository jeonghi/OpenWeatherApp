////
////  WeatherDataView.swift
////  OpenWeatherApp
////
////  Created by 쩡화니 on 10/1/24.
////

import SwiftUI


// MARK: Properties
struct CurrWeatherMonitorView {
  
  private var weatherDataList: [WeatherDataItem]
  
  init(_ weather: CurrentWeather?) {
    
    let humidityItem = WeatherDataItem(name: "습도", display: weather?.humidity.asformattedPercent())
    let cloudItem = WeatherDataItem(name: "구름", display: weather?.cloudCover.asformattedPercent())
    let windItem = WeatherDataItem(name: "바람 속도", display: weather?.windSpeed.asFormatted())
    let pressure = WeatherDataItem(name: "기압", display: weather?.pressure.asFormatted())
    
    weatherDataList = [
      humidityItem,
      cloudItem,
      windItem,
      pressure
    ]
  }
}

private enum Metric {
  static let gridHSpacing: CGFloat = 16
  static let gridVSpacing: CGFloat = 16
}

// MARK: Layout
extension CurrWeatherMonitorView: View {
  var body: some View {
    gridView()
  }
}

extension CurrWeatherMonitorView {
  private func gridView() -> some View {
    // 그리드 레이아웃: 2열로 설정
    
    let gridItem = GridItem(.flexible(), spacing: Metric.gridHSpacing)
    
    let columns: [GridItem] = .init(repeating: gridItem, count: 2)
    
    return LazyVGrid(columns: columns, spacing: Metric.gridVSpacing) {
      ForEach(weatherDataList, id: \.self) { data in
        gridCell(for: data)
          .aspectRatio(1, contentMode: .fit) // 1:1 비율 유지
      } //: ForEach
    }
  }
  
  private func gridCell(for type: WeatherDataItem) -> some View {
    GeometryReader { geometry in
      HeaderContainerView {
        Text(type.name)
      } contentView: {
        ZStack {
          Color.clear
          if let display = type.display {
            Text(display)
              .font(.title)
              .ex.hLeading()
          } else {
            ProgressView()
          }
        }
      } //: HeaderContainerView
      .frame(
        width: geometry.size.width,
        height: geometry.size.width
      ) // 1:1 비율
    } //: GeometryReader
  }
}

private struct WeatherDataItem: Hashable {
  let name: String
  let display: String?
}
