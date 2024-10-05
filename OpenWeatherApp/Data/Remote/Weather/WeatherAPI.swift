//
//  WeatherRouter.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/1/24.
//

import Foundation

enum WeatherAPI {
  case fetchWeatherInfo(params: GetCityWeatherInfoDTO.Request)
}

extension WeatherAPI: RouterType {
  
  var baseUrl: String {
    AppEnvironment.baseUrl
  }
  
  var path: String {
    switch self {
    case .fetchWeatherInfo:
      return "/data/3.0/onecall"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .fetchWeatherInfo:
      return .get
    }
  }
  
  var headers: [String : String]? {
    [:]
  }
  
  var parameters: [String : Any]? {
    switch self {
    case .fetchWeatherInfo(let params):
      var dict = params.asDictionary()
      dict?["appid"] = AppEnvironment.apiKey
      dict?["lang"] = "kr"
      return dict
    }
  }
  
  var body: Data? {
    nil
  }
}
