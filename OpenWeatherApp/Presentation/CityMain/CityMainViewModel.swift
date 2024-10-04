//
//  CityMainViewModel.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/1/24.
//

import Foundation
import Combine

protocol CityMainViewModelType: BaseViewModelType {}

final class CityMainViewModel: CityMainViewModelType {
  
  // MARK: Dependencies
  private(set) var cityUseCase: CityUseCaseType
  
  // MARK: Properties
  private(set) var cancellables: Set<AnyCancellable> = .init()
  private(set) var cancellableTaskBag: AnyCancellableTaskBag = .init()
  
  var input = Input()
  @Published private(set) var output = Output()
  
  // MARK: Constructor
  init(
    cityUseCase: CityUseCaseType
  ) {
    self.cityUseCase = cityUseCase
    transform()
  }
  
  // MARK: Transform
  func transform() {
    bindToSelectCity()
    bindToViewTask()
  }
  
  private func bindToViewTask() {
    let viewTask = input.viewTask
    
    viewTask
      .sink { [weak self] _ in
        guard let self else { return }
        Task {
          let city = await self.cityUseCase.loadLatestCity()
          self.input.selectCity.send(city)
        }
      }
      .store(in: &cancellables)
  }
  
  private func bindToSelectCity() {
    let selectCity = input.selectCity
      .throttle(for: .seconds(0.5), scheduler: DispatchQueue.global(), latest: true)
      .drop { [weak self] in $0 == self?.output.city }
    
    selectCity
      .sink { [weak self] value in
        self?.updateCityState(value)
      }
      .store(in: &cancellables)
    
    selectCity
      .compactMap { $0 }
      .sink { [weak self] city in
        guard let self else { return }
        Task {
          do {
            let weather = try await self.cityUseCase.fetchCityWeather(for: city)
            self.updateWeatherState(weather)
          } catch {
            self.updateErrorState(error)
          }
        }.store(in: cancellableTaskBag)
      }
      .store(in: &cancellables)
  }
  
  // MARK: Input
  struct Input {
    
    // MARK: Lifecycle
    var viewTask = PassthroughSubject<Void, Never>()
    var selectCity = PassthroughSubject<City?, Never>()
    
    // MARK: Interaction
    var tappedSearchBar = PassthroughSubject<Void, Never>()
    
    // MARK: SideEffectHandler
    var fetchWeather = PassthroughSubject<Void, Never>()
    var showingError = PassthroughSubject<Error?, Never>()
  }
  
  // MARK: Output
  struct Output {
    var city: City?
    var searchText: String = ""
    var isLoading: Bool = true
    var currWeather: CurrentWeather?
    var hourForecast: Forecast<HourWeather>?
    var dayForecast: Forecast<DayWeather>?
    var error: Error?
  }
}

extension CityMainViewModel {
  
  private func updateWeatherState(_ weather: Weather?) {
    Task {
      await MainActor.run {
        
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .day, value: 0, to: Date())! // 오늘
        let twoDayLater = calendar.date(byAdding: .day, value: 2, to: startDate)! // 이틀 후
        let fiveDayLater = calendar.date(byAdding: .day, value: 5, to: startDate)! // 5일 후
        
        output.currWeather = weather?.currentWeather
        output.hourForecast = weather?.hourlyForecast.filteredForecast(from: startDate, to: twoDayLater, interval: 3)
        output.dayForecast = weather?.dailyForecast.filteredForecast(from: startDate, to: fiveDayLater)
      }
    }.store(in: cancellableTaskBag)
  }
  
  private func updateErrorState(_ error: Error?) {
    Task {
      await MainActor.run {
        output.error = error
      }
    }.store(in: cancellableTaskBag)
  }
  
  private func updateCityState(_ city: City?) {
    Task {
      await MainActor.run {
        output.city = city
        initWeatherState()
      }
    }.store(in: cancellableTaskBag)
  }
  
  private func initWeatherState() {
    Task {
      await MainActor.run {
        output.currWeather = nil
        output.hourForecast = nil
        output.dayForecast = nil
      }
    }
  }
}
