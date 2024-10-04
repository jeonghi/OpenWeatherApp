////
////  WeatherDataView.swift
////  OpenWeatherApp
////
////  Created by 쩡화니 on 10/1/24.
////
//
//import SwiftUI
//
//// MARK: Properties
//struct CurrWeatherMonitorView {
//  
//  private let weather: CurrentWeather?
//  
//  private var weatherDataList: [OtherWeatherDataType] {
//    
//  }
//  
//  init(_ weather: CurrentWeather?) {
//    self.weather = weather
//  }
//}
//
//private enum Metric {
//  static let gridHSpacing: CGFloat = 16
//  static let gridVSpacing: CGFloat = 16
//}
//
//// MARK: Layout
//extension CurrWeatherMonitorView: View {
//  var body: some View {
//    gridView()
//  }
//}
//
//extension CurrWeatherMonitorView {
//  private func gridView() -> some View {
//    // 그리드 레이아웃: 2열로 설정
//    
//    let gridItem = GridItem(.flexible(), spacing: Metric.gridHSpacing)
//    
//    let columns: [GridItem] = .init(repeating: gridItem, count: 2)
//    
//    return LazyVGrid(columns: columns, spacing: Metric.gridVSpacing) {
//      ForEach(weatherDataList) { data in
//        gridCell(for: data.type)
//          .aspectRatio(1, contentMode: .fit) // 1:1 비율 유지
//      } //: ForEach
//    }
//  }
//  
//  private func gridCell(for type: OtherWeatherDataType) -> some View {
//    GeometryReader { geometry in
//      ZStack {
//        HeaderContainerView {
//          Text(type.name)
//        } contentView: {
//          Text(type.formattedValue)
//            .font(.largeTitle)
//        } //: HeaderContainerView
//      } //: ZStack
//      .frame(
//        width: geometry.size.width,
//        height: geometry.size.width
//      ) // 1:1 비율
//    } //: GeometryReader
//  }
//}
