//
//  ContentView.swift
//  FoodReviewBlog
//
//  Created by kim sunchul on 2023/10/04.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI
import DI
import LaunchInterface
import AppStateInterface

struct ContentView: View {

  // MARK: - Property

  @StateObject var appState: AppState = DIContainer.resolve(
    for: AppStateKey.self
  )

  var body: some View {
    NavigationStack(path: self.$appState.router.main) {
      Text("Main")
      .navigationDestination(for: MainRoutePath.self) { path in
        switch path {
        case .launch: DIContainer.resolveView(for: LaunchViewKey.self)
            .toolbar(.hidden, for: .navigationBar)
        }
      }
    }
  }
}


#Preview {
  AppEnvironment.bootstrap()
  return ContentView()
}
