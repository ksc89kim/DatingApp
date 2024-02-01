//
//  BackButton.swift
//  Util
//
//  Created by kim sunchul on 2/1/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import SwiftUI

public struct BackButton: View {
  
  // MARK: - Property
  
  private let action: () -> Void
  
  private let size: CGSize
  
  private let touchPadding: EdgeInsets
  
  public var body: some View {
    Button(
      action: self.action,
      label: {
        Image(systemName: "chevron.backward")
          .resizable()
          .frame(width: self.size.width, height: self.size.height)
          .padding(self.touchPadding)
          .foregroundColor(UtilAsset.MainColor.background.swiftUIColor)
      }
    )
    .accessibilityLabel("뒤로 가기")
  }
  
  // MARK: - Init
  
  public init(
    size: CGSize = .init(width: 10, height: 18),
    touchPadding: EdgeInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0),
    action: @escaping () -> Void
  ) {
    self.action = action
    self.size = size
    self.touchPadding = touchPadding
  }
}


#Preview {
  BackButton(action: {})
}
