//
//  Environment.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/5/24.
//

import Foundation

public enum AppEnvironment {
  // MARK: - Keys
  private enum Keys {
    enum Plist {
      static let baseUrl = "BASE_URL"
      static let apiKey = "API_KEY"
    }
  }
  
  // MARK: - Plist
  private static let infoDictionary: [String: Any] = {
    guard let dict = Bundle.main.infoDictionary else {
      fatalError("Plist file not found")
    }
    return dict
  }()
  
  // MARK: - Plist values
  static let baseUrl: String = {
    guard let baseUrl = AppEnvironment.infoDictionary[Keys.Plist.baseUrl] as? String else {
      fatalError("Root URL not set in plist for this environment")
    }
    return baseUrl
  }()
  
  static let apiKey: String = {
    guard let apiKey = AppEnvironment.infoDictionary[Keys.Plist.apiKey] as? String else {
      fatalError("API Key not set in plist for this environment")
    }
    return apiKey
  }()
}
