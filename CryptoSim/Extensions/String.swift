//
//  String.swift
//  CryptoSim
//
//  Created by Pat Butler on 2022-05-12.
//

import Foundation


extension String {
  
  var removingHTMLOccurances: String {
    return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
  }
}
