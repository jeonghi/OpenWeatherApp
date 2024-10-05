//
//  ViewExtension.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/5/24.
//

import SwiftUI

// MARK: - Ex 구조체 정의
public struct ViewExtension<Content: View>: View {
  
  /// 원래의 View를 보관하기 위한 프로퍼티
  var content: Content
  
  public var body: some View {
    content
  }
}
