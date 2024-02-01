//
//  ProfilePlaceHolder.swift
//  Util
//
//  Created by kim sunchul on 2/2/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import SwiftUI

public struct ProfilePlaceHolder: View {
  
  // MARK: - Define
  
  typealias ColorAssets = UtilAsset.UtilColor
  
  // MARK: - Property
  
  public var body: some View {
    GeometryReader { geometry in
      Circle()
        .foregroundColor(ColorAssets.profilePlaceholder.swiftUIColor)
        .overlay {
          Image(systemName: "person.fill")
            .resizable()
            .scaledToFit()
            .frame(
              width: geometry.size.width * 0.5,
              height: geometry.size.height * 0.5
            )
            .foregroundColor(ColorAssets.profilePlaceholderPerson.swiftUIColor)
        }
    }
  }
  
  // MARK: - Init
  
  public init() {}
}

#Preview {
  ProfilePlaceHolder()
}
