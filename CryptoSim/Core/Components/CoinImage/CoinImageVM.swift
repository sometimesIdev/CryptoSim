//
//  CoinImageVM.swift
//  CryptoSim
//
//  Created by Pat Butler on 2022-05-06.
//

import SwiftUI
import Combine


class CoinImageVM: ObservableObject {
  
  @Published var image: UIImage? = nil
  @Published var isLoading: Bool = false
  
  private let coin: Coin
  private let dataSerivce: CoinImageSerivce
  private var cancellables = Set<AnyCancellable>()
  
  init(coin: Coin) {
    self.coin = coin
    self.dataSerivce = CoinImageSerivce(coin: coin)
    self.addSubscribers()
    self.isLoading = true
  }
  
  private func addSubscribers() {
    dataSerivce.$image
      .sink { [weak self] _ in
        self?.isLoading = false
      } receiveValue: { [weak self] returnedImage in
        self?.image = returnedImage
      }
      .store(in: &cancellables)

  }
}
