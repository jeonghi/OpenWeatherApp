//
//  CitySearchView.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/1/24.
//

import SwiftUI

// MARK: Properties
struct CitySearchView {
  
  @ObservedObject var viewModel: CitySearchViewModel
  
  init(viewModel: CitySearchViewModel) {
    self.viewModel = viewModel
  }
}

// MARK: Metric
private enum Metric {
  static let listItemHInset: CGFloat = 10
  static let listItemVInset: CGFloat = 10
}

// MARK: Layout
extension CitySearchView: BaseViewType {
  var body: some View {
    VStack {
      searchBarView()
      if viewModel.output.isLoading {
        loadingIndicatorView()
          .ex.vCenter()
      }
      else {
        ZStack {
          if(viewModel.output.queryResult.isEmpty) {
            Text("검색 결과가 없어요 🥹")
              .ex.vCenter()
          } else {
            ScrollView {
              searchResultTableView(for: viewModel.output.queryResult)
            } //: ScrollView
          }
        }
      } //: VStack
    }
    .background(WeatherStyle.Color.background)
    .ex.foreground(WeatherStyle.Color.font)
    .ex.fullFrame()
  }
}

// MARK: Components
private extension CitySearchView {
  
  func loadingIndicatorView() -> some View {
    ProgressView()
  }
  
  func searchBarView() -> some View {
    SearchBar(
      text: Binding(get: {
        viewModel.output.query
      }, set: { updatedText in
        viewModel.input.searchQueryInput.send(updatedText)
      })
    )
  }
  
  func searchResultTableView(for cities: [City]) -> some View {
    LazyVStack {
      ForEach(cities, id: \.self) { city in
        Button(action: {
          viewModel.input.selectCity.send(city)
        }) {
          searchResultTableViewCell(for: city)
        } //: Button
      } //: ForEach
      if !viewModel.output.isLastPage {
        loadingIndicatorView()
          .onAppear {
            viewModel.input.fetchMoreCity.send()
          }
      }
    } //: LazyVStack
  }
  
  func searchResultTableViewCell(for city: City) -> some View {
    VStack(alignment: .leading) {
      Text(city.name) // 도시 이름
        .bold()
      Text(city.country) // 나라
    } //: VStack
    .ex.hLeading()
    .padding(.horizontal, Metric.listItemHInset)
    .padding(.vertical, Metric.listItemVInset)
  }
}


#if(DEBUG)
#Preview {
  
  let viewModel = CitySearchViewModel.init(
    cityUseCase: CityUseCaseMock.shared
  )
  
  CitySearchView(viewModel: viewModel)
}
#endif
