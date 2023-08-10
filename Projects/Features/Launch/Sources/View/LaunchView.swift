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

  public var body: some View {
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
  }

  // MARK: - Init

  public init() {
  }
}

struct LaunchView_Previews: PreviewProvider {
  static var previews: some View {
    LaunchView()
  }
}
