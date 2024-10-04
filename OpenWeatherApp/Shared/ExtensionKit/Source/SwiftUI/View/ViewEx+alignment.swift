//
//  ViewEx+alignment.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/5/24.
//

import SwiftUI

public extension ViewExtension {
  
  /// 수평 정렬: leading
  func hLeading() -> some View {
    content.frame(maxWidth: .infinity, alignment: .leading)
  }
  
  /// 수평 정렬: trailing
  func hTrailing() -> some View {
    content.frame(maxWidth: .infinity, alignment: .trailing)
  }
  
  /// 수평 정렬: center
  func hCenter() -> some View {
    content.frame(maxWidth: .infinity, alignment: .center)
  }
  
  /// 수직 정렬: top
  func vTop() -> some View {
    content.frame(maxHeight: .infinity, alignment: .top)
  }
  
  /// 수직 정렬: bottom
  func vBottom() -> some View {
    content.frame(maxHeight: .infinity, alignment: .bottom)
  }
  
  /// 수직 정렬: center
  func vCenter() -> some View {
    content.frame(maxHeight: .infinity, alignment: .center)
  }
}
