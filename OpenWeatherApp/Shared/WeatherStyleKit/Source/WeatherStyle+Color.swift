//
//  WeatherStyle+Color.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/1/24.
//

import SwiftUI
// MARK: 시멘틱
public extension WeatherStyle.Color {
  static var background: Color { oceanMist }
  static var containerBackground: Color { skyBlue }
  static var font: Color { light }
  static var searchBarTint: Color { steelBlue }
  static var searchBarBackground: Color { softBreeze }
}

// MARK: 팔레트
private extension WeatherStyle.Color {
  static let oceanMist = Color("oceanMist") // 배경 색상
  static let skyBlue = Color("skyBlue") // 컨테이너 배경 색상
  static let light = Color("white") // 폰트 색상
  static let steelBlue = Color("steelBlue") // 서치바 틴트 색상
  static let softBreeze = Color("softBreeze") // 서치바 배경 색상
}

