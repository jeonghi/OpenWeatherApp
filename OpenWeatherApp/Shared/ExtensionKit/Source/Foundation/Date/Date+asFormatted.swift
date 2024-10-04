//
//  Date+asFormatted.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/1/24.
//

import Foundation

extension Date {
  
  private func asFormattedString(for format: String = "yyyy-MM-dd HH:mm:ss") -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    dateFormatter.locale = Locale(identifier: "ko_KR") // 현재 로케일 명시
    dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")!
    let localTimeString = dateFormatter.string(from: self) // 4. 로컬 시간 출력
    return localTimeString
  }
  
  func asFormattedDayOfWeekString() -> String? {
    
    var calendar = Calendar.current
    calendar.locale = Locale(identifier: "ko_KR") // 한국어 로케일 설정
    calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!
    
    let hourDate = self
    let currentDate = Date()
    
    // 현재 날짜와의 차이를 계산
    let components = calendar.dateComponents([.day], from: currentDate, to: hourDate)
    
    switch components.day {
    case 0:
      return "오늘" // 현재 날짜
    default:
      return self.asFormattedString(for: "E")
    }
  }
  
  func asFormattedTimeString() -> String? {
    
    var calendar = Calendar.current
    calendar.locale = Locale(identifier: "ko_KR") // 한국어 로케일 설정
    calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!
    let currentDate = Date()
    let hourDate = self
    
    // 현재 시간과의 차이를 계산
    let components = calendar.dateComponents([.hour], from: currentDate, to: hourDate)
    
    if components.hour == 0 {
      return "지금"
    } else {
      guard let formatted = self.asFormattedString(for: "a h") else {
        return nil
      }
      
      let suffix: String = "시"
      
      return "\(formatted)\(suffix)"
    }
  }
}
