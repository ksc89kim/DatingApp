//
//  LaunchView.swift
//  Launch
//
//  Created by kim sunchul on 2023/08/09.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI

public struct LaunchView: View {

  // MARK: - Property

  @ObservedObject private var viewModel: LaunchViewModel

  public var body: some View {
    ZStack {
      VStack(
        alignment: .center,
        spacing: 24
      ) {
        Image(systemName: "highlighter")
          .resizable()
          .frame(width: 100, height: 100)
        Text("Food Blog Review")
          .font(.system(size: 26, weight: .bold))
      }
      VStack {
        Spacer()
        Text(self.viewModel.completionCount)
          .font(.system(size: 16, weight: .bold))
        Spacer().frame(height: 16)
      }
    }
    .onAppear {
      self.viewModel.run()
    }
  }

  // MARK: - Init

  public init(viewModel: LaunchViewModel) {
    self.viewModel = viewModel
  }
}

struct LaunchView_Previews: PreviewProvider {
  
  static var previews: some View {
    let viewModel: LaunchViewModel = .init(builder: nil)
    viewModel.completionCount = "1/1"
    return LaunchView(viewModel: viewModel)
  }
}
