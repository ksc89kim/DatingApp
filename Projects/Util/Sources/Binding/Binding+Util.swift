//
//  Binding+Util.swift
//  Util
//
//  Created by kim sunchul on 11/13/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI

public extension Binding where Value == String {
    func max(_ limit: Int) -> Self {
        if self.wrappedValue.count > limit {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.dropLast())
            }
        }
        return self
    }
}
