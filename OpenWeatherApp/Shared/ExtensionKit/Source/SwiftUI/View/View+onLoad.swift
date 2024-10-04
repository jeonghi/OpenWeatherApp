//
//  View+onLoad.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/5/24.
//

import SwiftUI

public extension ViewExtension {
  
  /// View의 Load시점을 감지하는 메서드
  func onLoad(
    perform action: (() -> Void)? = nil
  ) -> some View {
    content
      .modifier(ViewDidLoadModifier(perform: action))
  }
}

private struct ViewDidLoadModifier: ViewModifier {
  @State private var didLoad = false
  private let action: (() -> Void)?
  
  init(perform action: (() -> Void)? = nil) {
    self.action = action
  }
  
  func body(content: Content) -> some View {
    content.onAppear {
      if didLoad == false {
        didLoad = true
        action?()
      }
    }
  }
}
