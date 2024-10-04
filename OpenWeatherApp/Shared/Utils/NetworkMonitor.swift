//
//  NetworkMonitor.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/1/24.
//

import SwiftUI
import Combine
import Network


final class NetworkMonitor: ObservableObject {
  
  static let shared = NetworkMonitor()
  
  private let networkMonitor = NWPathMonitor()
  private let workerQueue = DispatchQueue(label: "NetworkMonitorQueue")
  
  @Published private(set) var isConnected: Bool = true
  
  private init() {
    networkMonitor.pathUpdateHandler = { path in
      DispatchQueue.main.async {
        self.isConnected = path.status == .satisfied
      }
    }
    networkMonitor.start(queue: workerQueue)
  }
}
