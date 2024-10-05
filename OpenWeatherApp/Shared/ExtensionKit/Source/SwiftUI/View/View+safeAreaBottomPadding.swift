//
//  View+safeAreaBottomPadding.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/5/24.
//

import SwiftUI

extension ViewExtension {
  
  /// safeArea 여부에 따라 bottom padding 다르게
  public func safeAreaBottomPadding(
    noSafeAreaPadding: CGFloat = 0,  // 안전 영역이 없을 때의 패딩
    hasSafeAreaPadding: CGFloat = 0  // 안전 영역이 있을 때의 패딩
  ) -> some View {
    
    content.modifier(
      SafeAreaBottomPaddingModifier(
        noSafeAreaPadding: noSafeAreaPadding,
        hasSafeAreaPadding: hasSafeAreaPadding,
        bottomInset: bottomSafeAreaInsets
      )
    )
  }
  
  private var bottomSafeAreaInsets: CGFloat {
    return UIApplication.keyWindow?.safeAreaInsets.bottom ?? 0
  }
}

private struct SafeAreaBottomPaddingModifier: ViewModifier {
  
  let noSafeAreaPadding: CGFloat
  let hasSafeAreaPadding: CGFloat
  let bottomInset: CGFloat
  
  func body(content: Content) -> some View {
    content
      .padding(.bottom, bottomInset == 0 ? noSafeAreaPadding : hasSafeAreaPadding)
  }
}
