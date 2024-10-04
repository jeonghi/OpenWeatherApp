//
//  AnyCancellableTask.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/1/24.
//

import Foundation

public protocol AnyCancellableTask {
  func cancel()
}

extension Task: AnyCancellableTask {}
