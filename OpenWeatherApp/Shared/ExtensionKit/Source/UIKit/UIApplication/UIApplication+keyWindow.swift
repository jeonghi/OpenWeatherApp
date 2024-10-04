//
//  UIApplication+keyWindow.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/5/24.
//

import UIKit

public extension UIApplication {
  
  static var keyWindow: UIWindow? {
    keyWindows.first
  }
  
  static var keyWindows: [UIWindow] {
    return UIApplication.shared.connectedScenes
      .compactMap { $0 as? UIWindowScene }
      .flatMap { $0.windows }
      .filter { $0.isKeyWindow }
  }
}
