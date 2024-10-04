//
//  SectionView.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/1/24.
//

import SwiftUI

// MARK: Properties
struct HeaderContainerView<Header: View, Content: View> {
  
  var headerView: Header
  var contentView: Content
  
  @State var topOffset: CGFloat = 0
  @State var bottomOffset: CGFloat = 0
  
  init(
    @ViewBuilder headerView: @escaping () -> Header,
    @ViewBuilder contentView: @escaping () -> Content
  ) {
    self.headerView = headerView()
    self.contentView = contentView()
  }
}

// MARK: Layout
extension HeaderContainerView: View {
  
  var body: some View {
    VStack(spacing: 0) {
      headerSection()
        .padding(.leading)
        .padding(.vertical, 8)
      Divider()
        .background(Color.white)
        .padding(.horizontal, 5)
      contentSection()
        .padding()
    }
    .background(
      WeatherStyle.Color.containerBackground
    )
    .ex.foreground(WeatherStyle.Color.font)
    .ex.cornerRadius(12)
  }
}

// MARK: Components
private extension HeaderContainerView {
  
  /// Header Section
  private func headerSection() -> some View {
    headerView
      .font(.caption)
      .ex.hLeading()
      .ex.cornerRadius(12, corners: bottomOffset < 38 ? .allCorners : [.topLeft, .topRight])
  }
  
  /// Content Section
  private func contentSection() -> some View {
    VStack {
      contentView
    }
    .clipped()
  }
}

#if DEBUG

#Preview {
  ScrollView {
    HeaderContainerView(headerView: {
      Text("Header")
    }, contentView: {
      Text("Content")
    })
    
    HeaderContainerView(headerView: {
      Text("Header")
    }, contentView: {
      Text("Content")
    })
  }
}

#endif
