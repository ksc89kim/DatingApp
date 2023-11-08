//
//  LogoView.swift
//  Util
//
//  Created by kim sunchul on 11/8/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI

public struct LogoView: View {

  // MARK: - Property

  var animate: Binding<Bool>

  public var body: some View {
    HStack(
      alignment: .center,
      spacing: 12
    ) {
      Image(systemName: "heart.fill")
        .resizable()
        .frame(width: 35, height: 30)
        .foregroundStyle(Color.Main.accent)
        .symbolEffect(.bounce, value: self.animate.wrappedValue)
      Text("Dating")
        .foregroundStyle(Color.Main.text)
        .font(.system(size: 32, weight: .bold))
    }
  }

  // MARK: - Init

  public init(animate: Binding<Bool>) {
    self.animate = animate
  }

  public init(animateValue: Bool = false) {
    self.animate = .init(
      get: { return animateValue},
      set: { _ in }
    )
  }
}

#Preview {
  LogoView(animate: Binding(
    get: { return true },
    set: { _ in }
  ))
}
