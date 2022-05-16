//
//  Statistics.swift
//  CryptoSim
//
//  Created by Pat Butler on 2022-05-06.
//

import SwiftUI

struct Statistics: Identifiable {
  let id = UUID().uuidString
  let title: String
  let value: String
  let percentageChange: Double?
  
  init(title: String, value: String, percentageChange: Double? = nil) {
    self.title = title
    self.value = value
    self.percentageChange = percentageChange
  }
}
