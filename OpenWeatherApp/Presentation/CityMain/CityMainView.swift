//
//  CityMainView.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/1/24.
//

import SwiftUI

// MARK: Properties
struct CityMainView {
  
  /// 선택한 도시
  @ObservedObject var viewModel: CityMainViewModel
  
  init(viewModel: CityMainViewModel) {
    self.viewModel = viewModel
  }
}

// MARK: Metric
private enum Metric {
  
  static let searchBarAndScrollSpacing: CGFloat = 10
  
  static let cityInfomationHeight: CGFloat = 150
  static let hourlyForecastHeight: CGFloat = 170
  static let dailyForecastHeight: CGFloat = 300
  static let mapRatio: CGFloat = 1
  
  enum ScrollContent {
    static let horizontalPadding: CGFloat = 10
    static let topPadding: CGFloat = 25
    static let bottomPadding: CGFloat = 10
    static let contentSpacing: CGFloat = 20
  }
}

// MARK: Layout
extension CityMainView: BaseViewType {
  
  var body: some View {
    VStack(spacing: Metric.searchBarAndScrollSpacing) {
      searchBarView()
      if let city = viewModel.output.city {
        scrollView(for: city)
          .padding(.horizontal, Metric.ScrollContent.horizontalPadding)
          .ex.safeAreaBottomPadding(
            noSafeAreaPadding: Metric.ScrollContent.bottomPadding
          )
      }
      else {
        loadingIndicatorView
          .ex.vCenter()
      }
    } //: ScrollView
    .ex.foreground(WeatherStyle.Color.font)
    .ex.fullFrame()
    .background(
      WeatherStyle.Color.background
    )
    .ex.task {
      viewModel.input.viewTask.send(())
    }
    .ex.alertNetworkMonitor()
  }
}

// MARK: Components
private extension CityMainView {
  
  // 서치바를 보여주되 bind Value를 상수로 설정함으로써, placeHolder를 유지하도록 설정
  func searchBarView() -> some View {
    Button(action: {
      viewModel.input.tappedSearchBar.send()
    }) {
      SearchBar(
        text: .constant(""),
        isUserInteractionEnabled: false
      )
    } //: Button
  }
  
  func scrollView(for city: City) -> some View {
    ScrollView(.vertical, showsIndicators: false) {
      scrollContentView(for: city)
    }
  }
  
  func scrollContentView(for city: City) -> some View {
    VStack(spacing: Metric.ScrollContent.contentSpacing) {
      cityInformationView()
        .frame(height: Metric.cityInfomationHeight)
      hourlyWeatherView()
        .frame(height: Metric.hourlyForecastHeight)
      dailyWeatherView()
        .frame(height: Metric.dailyForecastHeight)
      cityMapView()
        .aspectRatio(Metric.mapRatio, contentMode: .fit)
      weatherDataView()
    } //: VStack
  }
  
  /// 도시의 정보
  @ViewBuilder
  func cityInformationView() -> some View {
    if let city = viewModel.output.city {
      CityDescriptionView(
        city: city,
        currWeather: viewModel.output.currWeather,
        dayWeather: viewModel.output.dayForecast?.first
      )
    } else {
      loadingIndicatorView
    }
  }
  
  /// 도시의 시간 별 예보
  func hourlyWeatherView() -> some View {
    
      HeaderContainerView {
        Text("시간별 일기예보")
      } contentView: {
        if let forecast = viewModel.output.hourForecast {
          HourlyWeatherForecastView(forecast)
        }
        else {
          loadingIndicatorView
        }
      } //: HeaderContainerView
  }
  
  /// 도시의 요일 별 예보
  func dailyWeatherView() -> some View {
    
      HeaderContainerView {
        Text("주간 일기예보")
      } contentView: {
        if let forecast = viewModel.output.dayForecast {
        DailyWeatherForecastView(forecast)
        } else {
          loadingIndicatorView
        }
      } //: HeaderContainerView
  }
  
  /// 도시의 강수량 정보
  @ViewBuilder
  func cityMapView() -> some View {
    if let city = viewModel.output.city {
      HeaderContainerView {
        Text("도시 위치")
      } contentView: {
        CityMapView(city: city)
      } //: HeaderContainerView
    } else {
      loadingIndicatorView
    }
  }
  
  func weatherDataView() -> some View {
    CurrWeatherMonitorView(viewModel.output.currWeather)
  }
  
  var loadingIndicatorView: some View {
    ZStack {
      Color.clear
      ProgressView()
    }
  }
}


#if(DEBUG)
#Preview {
  
  let viewModel = CityMainViewModel.init(
    cityUseCase: CityUseCaseImpl.shared
  )
  
  CityMainView(viewModel: viewModel)
}
#endif
