//
//  ChipContainerView.swift
//  Util
//
//  Created by kim sunchul on 2/17/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import SwiftUI

public struct ChipContainerView: View {
  
  // MARK: - Define
  
  public enum Limit {
    case infinity
    case value(Int)
  }
  
  // MARK: - Property
  
  let limitCount: Limit
  
  let items: [Chip]
  
  let spacing: CGFloat
  
  public var appeance: ChipAppearance
  
  @Binding
  var selections: Set<Chip>
  
  public var body: some View {
    var width: CGFloat = .zero
    var height: CGFloat = .zero
    
    return GeometryReader { geo in
      ZStack(alignment: .topLeading) {
        ForEach(self.items) { item in
          let isSelected = self.selections.contains(item)
          ChipView(
            title: item.title.stringValue,
            isSelected: isSelected,
            appearance: self.appeance
          )
          .onTapGesture {
            if isSelected {
              self.selections.remove(item)
            } else {
              switch self.limitCount {
              case .infinity:
                self.selections.insert(item)
              case .value(let limitCount):
                if self.selections.count < limitCount {
                  self.selections.insert(item)
                }
              }
            }
          }
          .padding([.horizontal, .vertical], self.spacing)
          .alignmentGuide(.leading, computeValue: { d in
            if abs(width - d.width) > geo.size.width {
              width = 0
              height -= d.height
            }
            let result = width
            if item == self.items.last {
              width = 0
            } else {
              width -= d.width
            }
            return result
          })
          .alignmentGuide(.top, computeValue: { _ in
            let result = height
            if item == self.items.last {
              height = 0 // last item
            }
            return result
          })
        }
      }
    }
  }
  
  // MARK: - Init
  
  public init(
    items: [Chip],
    selections: Binding<Set<Chip>>,
    appearance: ChipAppearance = .init(),
    spacing: CGFloat = 4,
    limitCount: Limit = .infinity
  ) {
    self.items = items
    self.appeance = appearance
    self._selections = selections
    self.spacing = spacing
    self.limitCount = limitCount
  }
}


#Preview {
  let selections: Chip = .init(key: "test", title: "테스트")
  
  return ChipContainerView(
    items: [
      selections,
      .init(key: "test2", title: "테스트2"),
      .init(key: "test3", title: "테스트3"),
      .init(key: "test4", title: "테스트4"),
      .init(key: "test5", title: "테스트5"),
      .init(key: "test6", title: "테스트6"),
      .init(key: "test7", title: "테스트7")
    ],
    selections: .constant([selections])
  )
}
