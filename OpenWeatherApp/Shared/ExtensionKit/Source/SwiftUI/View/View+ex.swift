//
//  View+ex.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/5/24.
//

import SwiftUI

// MARK: - View Extension
public extension View {
  
  /// View에 Ex 네임스페이스를 추가하여 커스텀 메서드를 사용할 수 있게 해줌.
  var ex: ViewExtension<Self> {
    return ViewExtension(content: self)
  }
}
