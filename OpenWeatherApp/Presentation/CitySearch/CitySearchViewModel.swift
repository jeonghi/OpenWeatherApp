// CitySearchViewModel.swift
// SimpleTest
//
// Created by 쩡화니 on 10/1/24.
//

import Foundation
import Combine


final class CitySearchViewModel: BaseViewModelType {
  
  // MARK: Dependencies
  private(set) var cityUseCase: CityUseCaseType
  
  // MARK: Properties
  private(set) var cancellables: Set<AnyCancellable> = .init()
  private(set) var cancellableTaskBag: AnyCancellableTaskBag = .init()
  
  var input = Input()
  @Published private(set) var output = Output()
  
  private var currPage = 0
  private let pageSize = 20
  var isFetching = false
  
  // MARK: Constructor
  init(
    cityUseCase: CityUseCaseType
  ) {
    self.cityUseCase = cityUseCase
    transform()
  }
  
  // MARK: Transform
  func transform() {
    
    input.fetchMoreCity
      .drop(while: { [weak self] in self?.output.isLoading ?? true })
      .drop(while: { [weak self] in self?.output.isLastPage ?? true })
      .print("publisher")
      .throttle(for: .seconds(1), scheduler: DispatchQueue.global(), latest: true)
      .sink { [weak self] in
        guard let self else { return }
        let query = output.query
        fetchMoreCity(query: query)
      }
      .store(in: &cancellables)
    
    bindToQueryInput()
  }
  
  private func bindToQueryInput() {
    let queryInput = input.searchQueryInput
    
    queryInput
      .receive(on: DispatchQueue.main)
      .assign(to: \.output.query, on: self)
      .store(in: &cancellables)
    
    queryInput
      .debounce(for: .seconds(0.3), scheduler: DispatchQueue.global())
      .sink { [weak self] query in
        guard let self else { return }
        resetPagination()
        fetchMoreCity(query: query)
      }
      .store(in: &cancellables)
  }
  
  /// 페이지네이션 초기화
  private func resetPagination(){
    currPage = 0
    updateState { [weak self] in
      self?.output.isLastPage = false
      self?.output.queryResult.removeAll()
    }
  }
  
  /// 페이지네이션 로딩
  private func fetchMoreCity(query: String) {
    Task(priority: .background) { [weak self] in
      guard let self else { return }
      
      updateState {
        self.output.isLoading = true
      }
      
      do {
        // 페이지네이션으로 가져온 도시 리스트
        let cities = try await self.cityUseCase.fetchCityList(
          page: self.currPage,
          pageSize: self.pageSize,
          query: query
        )
        
        // 데이터가 기대한 페이지 크기보다 작으면 마지막 페이지로 설정
        let isLastPage = cities.count < self.pageSize
        
        // State 업데이트
        self.updateState {
          self.output.queryResult.append(contentsOf: cities) // 기존 데이터에 추가
          self.output.isLoading = false
          self.output.isLastPage = isLastPage
        }
        
        // 현재 페이지를 증가시킴
        if !isLastPage {
          self.currPage += 1
        }
        
      } catch {
        self.updateState {
          self.output.error = error
          self.output.isLoading = false
        }
      }
    }
  }
  
  private func updateState(_ updates: @escaping () -> Void) {
    Task {
      await MainActor.run {
        updates()
      }
    }
    .store(in: cancellableTaskBag)
  }
  
  // MARK: Input
  struct Input {
    
    // MARK: Interaction
    var searchQueryInput = CurrentValueSubject<String, Never>("")
    var selectCity = PassthroughSubject<City, Never>()
    var fetchMoreCity = PassthroughSubject<Void, Never>()
  }
  
  // MARK: Output
  struct Output {
    var query: String = ""
    var isShowingSheet: Bool = false
    var queryResult: [City] = []
    var isLoading: Bool = true
    var error: Error?
    var isLastPage: Bool = false
  }
}

