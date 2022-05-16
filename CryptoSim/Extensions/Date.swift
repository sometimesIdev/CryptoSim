//
//  Date.swift
//  CryptoSim
//
//  Created by Pat Butler on 2022-05-12.
//

import Foundation

extension Date {
  
  init(coinGeckString: String) {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss:SSSZ"
    let date = formatter.date(from: coinGeckString) ?? Date()
    self.init(timeInterval: 0, since: date)
  }
  
  private var shortFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
  }
  
  func asShortDateString() -> String {
    return shortFormatter.string(from: self)
  }
}
