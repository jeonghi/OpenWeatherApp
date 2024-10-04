//
//  View+foreground.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/5/24.
//

import SwiftUI

public extension ViewExtension {
  func foreground(_ color: Color) -> some View {
    content
      .modifier(ForegroundModifier(color: color))
  }
}


private struct ForegroundModifier: ViewModifier {
  let color: Color
  
  func body(content: Content) -> some View {
    if #available(iOS 15.0, *) {
      content
        .foregroundStyle(color)
    } else {
      content
        .foregroundColor(color)
    }
  }
}
