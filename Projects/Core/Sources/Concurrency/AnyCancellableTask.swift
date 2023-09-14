//
//  AnyCancellableTask.swift
//  Core
//
//  Created by kim sunchul on 2023/09/14.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public protocol AnyCancellableTask {

  // MARK: - Method
  
  func cancel()
}


extension Task: AnyCancellableTask {
}
