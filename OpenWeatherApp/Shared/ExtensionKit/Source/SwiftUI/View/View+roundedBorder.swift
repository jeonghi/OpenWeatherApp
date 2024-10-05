//
//  View+roundedBorder.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/5/24.
//

import SwiftUI

public extension ViewExtension {
  
  func roundedBorder(
    _ color: Color = .clear,
    radius: CGFloat = 0,
    lineWidth: CGFloat = 1.0
  ) -> some View {
    
    content.modifier(
      RoundedBorderModifier(
        color: color,
        radius: radius,
        lineWidth: lineWidth
      )
    )
  }
}

private struct RoundedBorderModifier: ViewModifier {
  
  let color: Color
  let radius: CGFloat
  let lineWidth: CGFloat
  
  func body(content: Content) -> some View {
    content
      .ex.overlay {
        RoundedRectangle(cornerRadius: radius)
          .stroke(color, lineWidth: lineWidth)
      }
  }
}
