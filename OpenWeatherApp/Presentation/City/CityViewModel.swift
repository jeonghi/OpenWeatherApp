//
//  CityViewModel.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/1/24.
//

import Foundation
import Combine


final class CityViewModel: BaseViewModelType {
  
  // MARK: Dependencies
  private let useCase: CityUseCaseType
  private(set) var cityMainViewModel: CityMainViewModel
  private(set) var citySearchViewModel: CitySearchViewModel?
  
  // MARK: Propertis
  private(set) var cancellables = Set<AnyCancellable>()
  private(set) var cancellableTaskBag: AnyCancellableTaskBag = .init()
  
  var input: Input = .init()
  @Published private(set) var output: Output = .init()
  
  // MARK: Constructor
  init(
    useCase: CityUseCaseType
  ) {
    self.useCase = useCase
    self.cityMainViewModel = .init(cityUseCase: useCase)
     transform()
   }
  
  func transform() {
    
    input.showingSheet
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] showingSheet in
        guard let self else { return }
        if(showingSheet) {
          citySearchViewModel = .init(cityUseCase: useCase)
          bindToSelectCity()
        } else {
          citySearchViewModel = nil
        }
        output.isShowingSheet = showingSheet
      })
      .store(in: &cancellables)
    
    cityMainViewModel.input.tappedSearchBar
      .throttle(for: .seconds(2), scheduler: DispatchQueue.global(), latest: true)
      .sink { [weak self] _ in
        self?.input.showingSheet.send(true)
      }
      .store(in: &cancellables)
  }
  
  /// 도시 선택 이벤트 연결
  private func bindToSelectCity() {
    
    let selectCity = citySearchViewModel?.input.selectCity
      .throttle(for: .seconds(1), scheduler: DispatchQueue.global(), latest: true)
    
    selectCity?
      .sink { [weak self] _ in
        self?.updateShowingSheetState(false)
      }
      .store(in: &cancellables)
    
    // 도시가 선택되면 상태를 업데이트하도록
    selectCity?
      .sink { [weak self] city in
        self?.cityMainViewModel.input.selectCity.send(city)
      }
      .store(in: &cancellables)
  }
  
  private func updateShowingSheetState(_ isShowing: Bool) {
    Task {
      await MainActor.run {
        output.isShowingSheet = isShowing
      }
    }
  }
  
  struct Input {
    
    // MARK: UI State
    var showingSheet = PassthroughSubject<Bool, Never>()
  }
  
  struct Output {
    var isShowingSheet: Bool = false
    var networkIsConnected: Bool = false
  }
}
