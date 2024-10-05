//
//  OpenWeatherAppApp.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/5/24.
//

import SwiftUI

@main
struct OpenWeatherAppApp: App {
  
  @UIApplicationDelegateAdaptor private var delegate: AppDelegate
  
  var body: some Scene {
    WindowGroup {
      CityView(viewModel: DIContainer.makeCityViewModel())
    }
  }
}
