//
//  CityView.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/5/24.
//


import SwiftUI

// MARK: Properties
struct CityView: BaseViewType {
  
  @ObservedObject private var viewModel: CityViewModel
  
  init(viewModel: CityViewModel) {
    self.viewModel = viewModel
  }
}

// MARK: Layout
extension CityView: View {
  var body: some View {
    ZStack {
      mainView
        .sheet(
          isPresented: Binding(
            get: { viewModel.output.isShowingSheet },
            set: { isShowing in viewModel.input.showingSheet.send(isShowing) }
          )
        ) {
          searchView
        }
    }
  }
}

private extension CityView {
  
  /// 메인 뷰
  var mainView: CityMainView {
    CityMainView(viewModel: viewModel.cityMainViewModel)
  }
  
  /// 검색 뷰
  var searchView: some View {
    ZStack {
      if let vm = viewModel.citySearchViewModel {
        CitySearchView(viewModel: vm)
      }
    }
  }
}

#if(DEBUG)
#Preview {
  
  let viewModel = CityViewModel.init(
    useCase: CityUseCaseImpl.shared
  )
  //  let viewModel = CityViewModel.init(
  //    useCase: CityUseCaseMock.shared
  //  )
  
  CityView(viewModel: viewModel)
}
#endif
