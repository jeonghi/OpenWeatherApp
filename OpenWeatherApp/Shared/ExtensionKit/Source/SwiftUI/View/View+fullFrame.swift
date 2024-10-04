//
//  View+fullFrame.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/5/24.
//

import SwiftUI

public extension ViewExtension {
  func fullFrame() -> some View {
    content
      .modifier(FullFrameModifier())
  }
}

private struct FullFrameModifier: ViewModifier {
  
  func body(content: Content) -> some View {
    content
      .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}
