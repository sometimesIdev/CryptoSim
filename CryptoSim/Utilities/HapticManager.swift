//
//  HapticManager.swift
//  CryptoSim
//
//  Created by Pat Butler on 2022-05-10.
//

import SwiftUI

class HapticManager {
  
  static private let genrator = UINotificationFeedbackGenerator()
  
  static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
    genrator.notificationOccurred(type)
  }
}
