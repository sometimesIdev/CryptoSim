//
//  CoinImageView.swift
//  CryptoSim
//
//  Created by Pat Butler on 2022-05-06.
//

import SwiftUI


struct CoinImageView: View {
  
  @StateObject var coinImageVM: CoinImageVM
  
  init(coin: Coin) {
    _coinImageVM = StateObject(wrappedValue: CoinImageVM(coin: coin))
  }
  
    var body: some View {
      ZStack {
        if let image = coinImageVM.image {
          Image(uiImage: image)
            .resizable()
            .scaledToFit()
        } else if coinImageVM.isLoading {
          ProgressView()
        } else {
          Image(systemName: "questionmark")
            .foregroundColor(.theme.secondaryText)
        }
      }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
      CoinImageView(coin: dev.coin)
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
