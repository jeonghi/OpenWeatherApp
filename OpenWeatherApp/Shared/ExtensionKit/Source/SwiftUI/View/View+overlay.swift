//
//  View+overlay.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/5/24.
//

import SwiftUI

public extension ViewExtension {
  func overlay<Overlay: View>(
    alignment: Alignment = .center,
    @ViewBuilder overlay: () -> Overlay
  ) -> some View {
    content
      .modifier(OverlayModifier(overlay: overlay(), alignment: alignment))
  }
}


private struct OverlayModifier<Overlay: View>: ViewModifier {
  let overlay: Overlay
  let alignment: Alignment
  
  func body(content: Content) -> some View {
    if #available(iOS 15.0, *) {
      content.overlay(overlay, alignment: alignment)
    } else {
      ZStack(alignment: alignment) {
        content
        overlay
      }
    }
  }
}
