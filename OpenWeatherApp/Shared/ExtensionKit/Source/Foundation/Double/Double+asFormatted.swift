//
//  Double+asFormatted.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/5/24.
//

import Foundation

extension Double {

  /// Double 값을 퍼센트 포맷으로 반환
  func asformattedPercent() -> String {
    
    let formatter = NumberFormatter()
    formatter.numberStyle = .percent // 퍼센트 스타일 설정
    formatter.minimumFractionDigits = 0 // 최소 소수점 자리수
    formatter.maximumFractionDigits = 0 // 최대 소수점 자리수
    formatter.multiplier = 100
    
    // Double 값을 NSNumber로 변환하여 포맷팅
    return formatter.string(from: NSNumber(value: self)) ?? "\(self)%"
  }
}
