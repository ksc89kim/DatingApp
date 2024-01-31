//
//  ChatDateManager.swift
//  Chat
//
//  Created by kim sunchul on 1/28/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation

struct ChatDate {
  
  // MARK: - Property
  
  private static let isoDateFormatter: ISO8601DateFormatter = {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    return formatter
  }()
  
  private static let dateFormatter: DateFormatter = {
    let formmatter = DateFormatter()
    formmatter.dateStyle = .medium
    formmatter.timeStyle = .short
    formmatter.timeZone = NSTimeZone.local
    formmatter.doesRelativeDateFormatting = true
    return formmatter
  }()
  
  // MARK: - Method
  
  static func date(from string: String) -> Date? {
    return self.isoDateFormatter.date(from: string)
  }
  
  static func string(from date: Date) -> String {
    return self.dateFormatter.string(from: date)
  }
}
