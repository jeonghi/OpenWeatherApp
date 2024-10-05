//
//  WeatherAPIError.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/1/24.
//

import Foundation

struct WeatherAPIError: APIClientErrorType {
  let code: Int
  let message: String
}

extension WeatherAPIError: LocalizedError {
  var errorDescription: String? { message }
}
