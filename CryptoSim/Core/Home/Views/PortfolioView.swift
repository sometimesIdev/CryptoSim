//
//  PortfolioView.swift
//  CryptoSim
//
//  Created by Pat Butler on 2022-05-08.
//

import SwiftUI

struct PortfolioView: View {
  
  @EnvironmentObject private var vm: HomeViewModel
  @State private var selectedCoin: Coin? = nil
  @State private var quantityText: String = ""
  @State private var showCheckmark: Bool = false
 
  
    var body: some View {
      NavigationView {
        ScrollView {
          VStack(alignment: .leading, spacing: 0) {
            SearchBarView(searchText: $vm.searchText)
            coinLogoList
            if selectedCoin != nil {
            	portfolioInputSection
            }
          }
        }
        .background(Color.theme.background.ignoresSafeArea())
        .navigationTitle("Edit Portfolio")
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            XMarkButton()
          }
          ToolbarItem(placement: .navigationBarTrailing) {
            trailingNavbarButtons
          }
        }
        .onChange(of: vm.searchText) { newValue in
          if newValue == "" {
            removeSelectedCoin()
          }
        }
      }
    }
  
  private var coinLogoList: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      LazyHStack(spacing: 10) {
        ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins) { coin in
          CoinLogoView(coin: coin)
          .frame(width: 75)
          .padding(4)
          .onTapGesture {
            withAnimation(.easeIn) {
              updateSelectedCoin(coin: coin)
            }
          }
          .background(
            RoundedRectangle(cornerRadius: 10)
              .stroke(selectedCoin?.id == coin.id ? Color.green : Color.clear, lineWidth: 1)
          )
        }
      }
      .frame(height: 120)
      .padding(.leading)
    }
  }
  
  private func updateSelectedCoin(coin: Coin) {
    selectedCoin = coin
    
    if let portfolioCoin = vm.portfolioCoins.first(where: { $0.id == coin.id }),
       let amount = portfolioCoin.currentHoldings {
      quantityText = "\(amount)"
    } else {
      quantityText = ""
    }
  }
  
  private var portfolioInputSection: some View {
      VStack(spacing: 20) {
        HStack {
          Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
          Spacer()
          Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
        }
        Divider()
        HStack {
          Text("Amount holding:")
          Spacer()
          TextField("Ex: 1.4", text: $quantityText)
            .multilineTextAlignment(.trailing)
            .keyboardType(.decimalPad)
        }
        Divider()
        HStack {
          Text("Current value:")
          Spacer()
          Text(getCurrentValue().asCurrencyWith2Decimals())
        }
      }
      .animation(.none, value: selectedCoin?.id)
      .padding()
      .font(.headline)
  	}
  
  private var trailingNavbarButtons: some View {
    HStack(spacing: 10) {
      Image(systemName: "checkmark")
        .opacity(showCheckmark ? 1.0 : 0.0)
      Button {
        saveButtonPressed()
      } label: {
        Text("Save".uppercased())
      }
      .opacity((selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0)
    }
  }
  
  private func getCurrentValue() -> Double {
    if let quantity = Double(quantityText) {
      return quantity * (selectedCoin?.currentPrice ?? 0)
    }
    return 0
  }
  
  private func saveButtonPressed() {
    guard
      let coin = selectedCoin,
    	let amount = Double(quantityText)
    	else { return }
    
    // save to portfoilio
    vm.updatePortfolio(coin: coin, amount: amount)
    
    // show checkmark
    withAnimation(.easeIn) {
      showCheckmark = true
      removeSelectedCoin()
    }
    
    // hide keyboard
    UIApplication.shared.endEditing()
    
    // hide checkmark
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
      showCheckmark = false
    }
    
    
  }
  
  private func removeSelectedCoin() {
    selectedCoin = nil
    vm.searchText = ""
  }
  
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
        .environmentObject(dev.homeVM)
    }
}
