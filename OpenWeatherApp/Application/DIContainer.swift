//
//  DIContainer.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/5/24.
//

import Foundation

enum DIContainer {
  static func makeCityViewModel() -> CityViewModel {
    return CityViewModel(
      useCase: CityUseCaseImpl.shared
    )
  }
  
  static func makeSearchViewModel() -> CitySearchViewModel {
    return CitySearchViewModel(
      cityUseCase: CityUseCaseImpl.shared
    )
  }
   
  static func makeMainViewModel() -> CityMainViewModel {
    return CityMainViewModel(
      cityUseCase: CityUseCaseImpl.shared
    )
  }
}
