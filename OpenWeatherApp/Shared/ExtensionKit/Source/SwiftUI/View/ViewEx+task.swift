//
//  ViewEx+task.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/5/24.
//

import SwiftUI

extension ViewExtension {
  func task(
    priority: TaskPriority = .background,
    closure: @escaping () async -> Void
  ) -> some View {
    content
      .modifier(TaskModifier(priority: priority, closure: closure))
  }
}

private struct TaskModifier: ViewModifier {
  
  let priority: TaskPriority
  var closure: () async -> Void
  
  init(priority: TaskPriority = .userInitiated, closure: @escaping () async -> Void) {
    self.priority = priority
    self.closure = closure
  }
  
  func body(content: Content) -> some View {
    if #available(iOS 15.0, *) {
      content
        .task {
          await closure()
        }
    } else {
      content
        .ex.onLoad {
          Task {
            await closure()
          }
        }
    }
  }
}

