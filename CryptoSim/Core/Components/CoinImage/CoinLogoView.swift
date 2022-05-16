//
//  CoinLogoView.swift
//  CryptoSim
//
//  Created by Pat Butler on 2022-05-09.
//

import SwiftUI

struct CoinLogoView: View {
  let coin: Coin
  
    var body: some View {
      VStack {
        CoinImageView(coin: coin)
          .frame(width: 50, height: 50)
        Text(coin.symbol.uppercased())
          .font(.headline)
          .foregroundColor(.theme.accent)
          .lineLimit(1)
          .minimumScaleFactor(0.5)
        Text(coin.name)
          .font(.caption)
          .foregroundColor(.theme.secondaryText)
          .lineLimit(2)
          .minimumScaleFactor(0.5)
          .multilineTextAlignment(.center)
      }
    }
}

struct CoinLogoView_Previews: PreviewProvider {
    static var previews: some View {
      Group {
        CoinLogoView(coin: dev.coin)
          .previewLayout(.sizeThatFits)
        CoinLogoView(coin: dev.coin)
          .previewLayout(.sizeThatFits)
          .preferredColorScheme(.dark)
      }
    }
}
