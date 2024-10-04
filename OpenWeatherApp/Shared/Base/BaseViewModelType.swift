//
//  BaseViewModelType.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/1/24.
//

import SwiftUI
import Combine

protocol BaseViewModelType: ObservableObject {
  
  associatedtype Input
  associatedtype Output
  
  var cancellables: Set<AnyCancellable> { get }
  var cancellableTaskBag: AnyCancellableTaskBag { get }
  var input: Input { get }
  var output: Output { get }
  
  func transform()
}
