//
//  View+cornerRadius.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/5/24.
//

import SwiftUI

public extension ViewExtension {
  
  func cornerRadius(_ radius: CGFloat, corners: UIRectCorner = .allCorners) -> some View {
    content.modifier(
      CornerRadiusModifier(
        radius: radius,
        corners: corners
      )
    )
  }
}

private struct CornerRadiusModifier: ViewModifier {
  
  let radius: CGFloat
  let corners: UIRectCorner
  
  func body(content: Content) -> some View {
    content
      .clipShape(RoundedCorner(radius: radius, corners: corners))
  }
}

private struct RoundedCorner: Shape {
  
  var radius: CGFloat = .infinity
  var corners: UIRectCorner = .allCorners
  
  init(radius: CGFloat, corners: UIRectCorner) {
    self.radius = radius
    self.corners = corners
  }
  
  func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(
      roundedRect: rect,
      byRoundingCorners: corners,
      cornerRadii: CGSize(width: radius, height: radius)
    )
    return Path(path.cgPath)
  }
}
