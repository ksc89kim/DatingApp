//
//  UserRegisterAction.swift
//  User
//
//  Created by kim sunchul on 2/11/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation
import Util
import UIKit

enum UserRegisterAction {
  case initUI
  case next
  case previous
  case birthday(Date)
  case height(String)
  case singleSelect(key: String, value: String?)
  case multipleSelect(key: String, value: Set<Chip>)
  case showAlbum
  case hideAlbum
  case selectedImage(image: UIImage?)
  case deleteImage(index: UserRegisterPhotoIndex)
}
