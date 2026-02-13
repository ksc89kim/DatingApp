//
//  Image+Kingfisher.swift
//  Util
//
//  Created by kim sunchul on 11/15/25.
//  Copyright © 2025 Tronplay. All rights reserved.
//

import Foundation
import Kingfisher
import SwiftUI

public struct LoadImage<PlaceHolder: View>: View {
  public var url: URL?
  public var placeHolderView: PlaceHolder?

  public init(url: URL? = nil, placeHolderView: PlaceHolder? = nil) {
    self.url = url
    self.placeHolderView = placeHolderView
    
  }
  
  public var body: KFAnimatedImage {
    var imageView = KFAnimatedImage(url)
      .cancelOnDisappear(true)
      .fade(duration: 1)
    if let placeHolderView {
      imageView = imageView
        .placeholder {
          placeHolderView
        }
    }
    return imageView
  }
}
