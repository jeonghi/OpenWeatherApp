//
//  UserDefaultWrapper.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/5/24.
//

import Foundation

@propertyWrapper
struct UserDefaultWrapper<T: Codable> {
  private let key: String
  private let defaultValue: T
  
  init(key: String, defaultValue: T) {
    self.key = key
    self.defaultValue = defaultValue
  }
  
  var wrappedValue: T {
    get {
      if let savedData = UserDefaults.standard.object(forKey: key) as? Data {
        let decoder = JSONDecoder()
        if let lodedObejct = try? decoder.decode(T.self, from: savedData) {
          return lodedObejct
        }
      }
      return defaultValue
    }
    set {
      let encoder = JSONEncoder()
      if let encoded = try? encoder.encode(newValue) {
        UserDefaults.standard.setValue(encoded, forKey: key)
      }
    }
  }
}
