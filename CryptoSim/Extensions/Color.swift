//
//  Color.swift
//  CryptoSim
//
//  Created by Pat Butler on 2022-05-05.
//

import SwiftUI

extension Color {
  
  static let theme = ColorTheme()
  static let launchTheme = LaunchTheme()
}

struct ColorTheme {
  
  let accent = Color("AccentColor")
  let background = Color("BackgroundColor")
  let green = Color("GreenColor")
  let red = Color("RedColor")
  let secondaryText = Color("SecondaryTextColor")
  
}

struct LaunchTheme {
  
  let background = Color("LaunchBackgroundColor")
  let accent = Color("LaunchAccentColor")
}
