//
//  CoinRowView.swift
//  CryptoSim
//
//  Created by Pat Butler on 2022-05-05.
//

import SwiftUI

struct CoinRowView: View {
  
  let coin: Coin
  let showHoldingsColumn: Bool
  
    var body: some View {
      HStack(spacing: 0) {
        leftColumn
        Spacer()
        if showHoldingsColumn {
          centreColumn
        }
        rightColumn
      }
      .font(.subheadline)
      .background(
        Color.theme.background.opacity(0.001)
      )
    }
  
  private var leftColumn: some View {
    HStack(spacing: 0) {
      Text("\(coin.rank)")
        .font(.caption)
        .foregroundColor(.theme.secondaryText)
        .frame(minWidth: 30)
      CoinImageView(coin: coin)
        .frame(width: 30, height: 30)
      Text(coin.symbol.uppercased())
        .font(.headline)
        .padding(.leading, 6)
        .foregroundColor(.theme.accent)
    }
  }
  
  private var centreColumn: some View {
    VStack(alignment: .trailing) {
      Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
        .bold()
      Text((coin.currentHoldings ?? 0).asNumberString())
    }
    .foregroundColor(.theme.accent)
  }
  
  private var rightColumn: some View {
    VStack(alignment: .trailing) {
      Text("\(coin.currentPrice.asCurrencyWith6Decimals())")
        .bold()
        .foregroundColor(.theme.accent)
      Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
        .foregroundColor(
          (coin.priceChangePercentage24H ?? 0) >= 0 ?
          Color.theme.green :
          Color.theme.red
        )
    }
    .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
  }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
      Group {
        CoinRowView(coin: dev.coin, showHoldingsColumn: true)
          .previewLayout(.sizeThatFits)
        CoinRowView(coin: dev.coin, showHoldingsColumn: true)
          .previewLayout(.sizeThatFits)
          .preferredColorScheme(.dark)
      }
    }
}
