//
//  SearchBar.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/1/24.
//

import SwiftUI
import UIKit

struct SearchBar: View {
  @Binding var text: String
  var isUserInteractionEnabled: Bool = true
  
  init(text: Binding<String>, isUserInteractionEnabled: Bool = true) {
    self._text = text
    self.isUserInteractionEnabled = isUserInteractionEnabled
  }
  
  var body: some View {
    SearchBarRepresentable(text: $text, isUserInteractionEnabled: isUserInteractionEnabled)
  }
}

private struct SearchBarRepresentable: UIViewRepresentable {
  
  @Binding var text: String
  var isUserInteractionEnabled: Bool = true
  
  init(text: Binding<String>, isUserInteractionEnabled: Bool = true) {
    self._text = text
    self.isUserInteractionEnabled = isUserInteractionEnabled
  }
  
  func makeUIView(context: UIViewRepresentableContext<SearchBarRepresentable>) -> UISearchBar {
    let searchBar = UISearchBar(frame: .zero)
    searchBar.delegate = context.coordinator
    searchBar.scopeBarBackgroundImage = nil
    searchBar.searchTextField.backgroundColor = UIColor(WeatherStyle.Color.searchBarBackground)
    searchBar.searchTextField.textColor = UIColor(WeatherStyle.Color.searchBarTint)
    searchBar.searchTextField.placeholder = "Search"
    searchBar.searchTextField.returnKeyType = .done
    searchBar.backgroundImage = UIImage()
    searchBar.backgroundColor = .clear
    searchBar.layer.backgroundColor = nil
    return searchBar
  }
  
  func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBarRepresentable>) {
    uiView.text = text
    uiView.isUserInteractionEnabled = isUserInteractionEnabled // 터치 활성화 여부 동기화
//    uiView.backgroundColor = .clear
//    uiView.isTranslucent = true
//    uiView.setBackgroundImage(nil, for: .any, barMetrics: .default)
    uiView.backgroundColor = nil
//    uiView.layer.borderColor = UIColor.clear.cgColor
  }
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(text: $text)
  }
}

extension SearchBarRepresentable {
  
  final class Coordinator: NSObject, UISearchBarDelegate {
    
    private let text: Binding<String>
    
    init(
      text: Binding<String>
    ) {
      self.text = text
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      text.wrappedValue = searchText
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
      searchBar.setShowsCancelButton(true, animated: true)
      return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
      searchBar.setShowsCancelButton(false, animated: true)
      return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
      searchBar.endEditing(true)
      searchBar.text = ""
      text.wrappedValue = ""
      searchBar.showsCancelButton = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      searchBar.endEditing(true)
      searchBar.setShowsCancelButton(false, animated: true)
    }
  }
}

#if(DEBUG)
#Preview {
  SearchBar(text: .constant(""))
    .background(Color.black)
}
#endif
