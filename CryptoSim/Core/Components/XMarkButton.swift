//
//  XMarkButton.swift
//  CryptoSim
//
//  Created by Pat Butler on 2022-05-08.
//

import SwiftUI

struct XMarkButton: View {
  
  @Environment(\.dismiss) private var dismiss
  
  var body: some View {
    Button {
     dismiss()
    } label: {
      Image(systemName: "xmark")
        .font(.headline)
    }
  }
}

struct XMarkView_Previews: PreviewProvider {
  static var previews: some View {
    XMarkButton()
      .previewLayout(.sizeThatFits)
  }
}

