//
//  UIApplicationExtension.swift
//  CryptoSim
//
//  Created by Pat Butler on 2022-05-06.
//

import SwiftUI

extension UIApplication {
  
  func endEditing() {
    sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
