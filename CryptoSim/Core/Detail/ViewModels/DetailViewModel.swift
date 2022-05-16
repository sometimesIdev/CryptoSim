//
//  DetailViewModel.swift
//  CryptoSim
//
//  Created by Pat Butler on 2022-05-11.
//

import SwiftUI
import Combine

class DetailViewModel: ObservableObject {
  
  @Published var overviewStatistics: [Statistics] = []
  @Published var additionalStatistics: [Statistics] = []
  @Published var coinDescription: String? = nil
  @Published var websiteURL: String? = nil
  @Published var redditURL: String? = nil
  @Published var coin: Coin
  
  private let coinDetailService: CoinDetailDataService
  private var cancellables = Set<AnyCancellable>()
  
  init(coin: Coin) {
    self.coin = coin
    self.coinDetailService = CoinDetailDataService(coin: coin)
    self.addSubscribers()
  }
  
  private func addSubscribers() {
    
    coinDetailService.$coinDetails
      .combineLatest($coin)
      .map(mapDataToStatistics)
      .sink { [weak self] returnedArrays in
        self?.overviewStatistics = returnedArrays.overview
        self?.additionalStatistics = returnedArrays.additional
      }
      .store(in: &cancellables)
    
    coinDetailService.$coinDetails
      .sink { [weak self] returnedCoinDeatils in
        self?.coinDescription = returnedCoinDeatils?.readableDescription
        self?.websiteURL = returnedCoinDeatils?.links?.homepage?.first
        self?.redditURL = returnedCoinDeatils?.links?.subredditURL
      }
      .store(in: &cancellables)
    
  }
  
  private func mapDataToStatistics(coinDetail: CoinDetail?, coin: Coin) -> (overview: [Statistics], additional: [Statistics]) {
    
    let oveviewArray = createOverviewArray(coin: coin)
    let additionalArray = createAdditionalArray(coinDetail: coinDetail)
    
    return (oveviewArray, additionalArray)
  }
  
  private func createOverviewArray(coin: Coin) -> [Statistics] {
    
    let price = coin.currentPrice.asCurrencyWith6Decimals()
    let priceChange = coin.priceChangePercentage24H
    let priceStat = Statistics.init(title: "Current Price", value: price, percentageChange: priceChange)
    
    let marketCap = "$" + (coin.marketCap?.formattedWithAbbreviations() ?? "")
    let marketCapChange = coin.marketCapChangePercentage24H
    let marketCapStat = Statistics(title: "Market Capitalization", value: marketCap, percentageChange: marketCapChange)
    
    let rank = "\(coin.rank)"
    let rankStat = Statistics(title: "Rank", value: rank)
    
    let volume  = "$" + (coin.totalVolume?.formattedWithAbbreviations() ?? "")
    let volumeStat = Statistics(title: "Volume", value: volume)
    
    let overviewArray = [
      priceStat, marketCapStat, rankStat, volumeStat
    ]
    return overviewArray
  }
  
  private func createAdditionalArray(coinDetail: CoinDetail?) -> [Statistics] {
    // additional
    let high = coin.high24H?.asCurrencyWith6Decimals() ?? "n/a"
    let highStat = Statistics(title: "24h High", value: high)
    
    let low = coin.low24H?.asCurrencyWith6Decimals() ?? "n/a"
    let lowStat = Statistics(title: "24h Low", value: low)
    
    let priceChange2 = coin.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
    let pricePercentChange2 = coin.priceChangePercentage24H
    let priceChangeStat = Statistics(title: "24h Price Change", value: priceChange2, percentageChange: pricePercentChange2)
    
    let marketCapChange2 = "$" + (coin.marketCapChangePercentage24H?.formattedWithAbbreviations() ?? "")
    let marketCapPercentChange2 = coin.marketCapChangePercentage24H
    let marketCapChangeStat = Statistics(title: "24hnMarket Cap Change", value: marketCapChange2, percentageChange: marketCapPercentChange2)
    
    let blockTime = coinDetail?.blockTimeInMinutes ?? 0
    let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
    let blockStat = Statistics(title: "Block Time", value: blockTimeString)
    
    let hashing = coinDetail?.hashingAlgorithm ?? "n/a"
    let hashingStat = Statistics(title: "Hashing Algorithm", value: hashing)
    
    let additionalArray = [
      highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat
    ]
    
    return additionalArray
  }
}
