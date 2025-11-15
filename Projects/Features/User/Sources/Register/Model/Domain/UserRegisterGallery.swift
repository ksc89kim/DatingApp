//
//  UserRegisterGallery.swift
//  User
//
//  Created by kim sunchul on 5/4/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation
import UserInterface
import SwiftUI

final class UserRegisterGallery: UserRegisterMain {
  
  // MARK: - Property
  
  weak var repository: UserRegisterRepositoryType?
  
  var isBottomDisable: Bool = true
  
  var firstImage: Image?
  
  var secondImage: Image?
  
  private var images: [UIImage] = []
  
  private var isAvailable: Bool {
    return self.images.count < 2
  }
  
  // MARK: - Init
  
  init() {}
  
  // MARK: - Method
  
  func onAppear() {
    self.isBottomDisable = self.isAvailable
  }

  func mergeRequest(_ request: UserRegisterRequest) -> UserRegisterRequest {
    var request = request
    request.imagesDatas = self.images.compactMap { uiImage -> Data? in
      return uiImage.jpegData(compressionQuality: 1.0)
    }
    return request
  }
  
  func insertImageIfNeeded(_ image: UIImage) {
    guard self.isAvailable else { return }
    if self.images.count < 1 {
      self.firstImage = .init(uiImage: image)
    } else {
      self.secondImage = .init(uiImage: image)
    }
    self.images.append(image)
    self.isBottomDisable = self.isAvailable
  }
  
  func deleteImageIfNeeded(_ index: UserRegisterPhotoIndex) {
    guard self.images.indices ~= index.rawIndex else { return }
    self.images.remove(at: index.rawIndex)
    if self.images.isEmpty {
      self.firstImage = nil
      self.secondImage = nil
    } else if let image = self.images.first {
      self.firstImage = .init(uiImage: image)
      self.secondImage = nil
    }
    self.isBottomDisable = self.isAvailable
  }
}
