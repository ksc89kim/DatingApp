//
//  ChipView.swift
//  Util
//
//  Created by kim sunchul on 2/17/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import SwiftUI

struct ChipView: View {
  
  // MARK: - Property
  
  let title: String
  
  let appearance: ChipAppearance
  
  let isSelected: Bool
  
  var body: some View {
    Text(self.title)
      .padding(self.appearance.edges)
      .foregroundColor(self.appearance.foregroundColor(isSelected: self.isSelected))
      .background(self.appearance.backgroundColor(isSelected: self.isSelected))
      .cornerRadius(self.appearance.cornerRadius)
  }
  
  // MARK: - Init
  
  init(
    title: String,
    isSelected: Bool,
    appearance: ChipAppearance = .init()
  ) {
    
    self.title = title
    self.isSelected = isSelected
    self.appearance = appearance
  }
}


#Preview {
  ChipView(title: "칩UI", isSelected: false)
}
