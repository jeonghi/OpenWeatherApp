//
//  Measurement+asFormatted.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/5/24.
//

import Foundation

extension Measurement where UnitType == UnitPressure {
  func asFormatted() -> String {
    let formatter = MeasurementFormatter()
    formatter.unitStyle = .medium // 단위 스타일 설정 (short, medium, long)
    formatter.unitOptions = .providedUnit // 제공된 단위를 그대로 사용
    formatter.numberFormatter.maximumFractionDigits = 0 // 소수점 자릿수 설정
    return formatter.string(for: self) ?? ""
  }
}

extension Measurement where UnitType == UnitTemperature {
  func asFormatted() -> String {
    let formatter = MeasurementFormatter()
    formatter.unitStyle = .medium // 단위 스타일 설정 (short, medium, long)
    formatter.unitOptions = .providedUnit // 제공된 단위를 그대로 사용
    formatter.numberFormatter.maximumFractionDigits = 0 // 소수점 자릿수 설정
    return formatter.string(for: self) ?? ""
  }
}

extension Measurement where UnitType == UnitSpeed {
  func asFormatted() -> String {
    let formatter = MeasurementFormatter()
    formatter.unitStyle = .medium // 단위 스타일 설정 (short, medium, long)
    formatter.unitOptions = .providedUnit // 제공된 단위를 그대로 사용
    formatter.numberFormatter.maximumFractionDigits = 2 // 소수점 자릿수 설정
    return formatter.string(for: self) ?? ""
  }
}
