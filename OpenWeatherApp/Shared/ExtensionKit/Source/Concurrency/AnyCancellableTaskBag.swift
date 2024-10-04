//
//  AnyCancellableTaskBag.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/1/24.
//

import Foundation

public final class AnyCancellableTaskBag {
  private var tasks: [any AnyCancellableTask] = []
  
  public init() {}
  
  public func add(task: any AnyCancellableTask) {
    tasks.append(task)
  }
  
  public func cancel() {
    tasks.forEach { $0.cancel() }
    tasks.removeAll()
  }
  
  deinit {
    cancel()
  }
}


extension Task {
  public func store(in bag: AnyCancellableTaskBag) {
    bag.add(task: self)
  }
}
