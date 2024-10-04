//
//  ViewEx+alertNetworkMonitor.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/5/24.
//

import SwiftUI

// Presentation 계층에서 따로 확장하는 메서드라 ExtensionKit에 두지 않고 별도로 분리
// 패키지로 ExtensionKit을 분리한다면 유용
public extension ViewExtension {
  func alertNetworkMonitor() -> some View {
    self
      .modifier(NetworkMonitorViewModifier())
  }
}

/// 별도의 네트워크 알림을 관리하는 창
private struct NetworkMonitorViewModifier: ViewModifier {
  
  @ObservedObject var networkMonitor = NetworkMonitor.shared
  
  func body(content: Content) -> some View {
    ZStack {
      if networkMonitor.isConnected {
        content
      } else {
        WeatherStyle.Color.background
          .ignoresSafeArea()
        Text("네트워크 연결이 불안정합니다 😮")
          .padding(.horizontal, 20)
          .padding(.vertical, 10)
          .background(WeatherStyle.Color.containerBackground)
          .ex.cornerRadius(6)
          .ex.foreground(WeatherStyle.Color.font)
          .ex.vCenter()
          .ex.hCenter()
      }
    }
  }
}
