//
//  HomeViewModel.swift
//  CryptoSim
//
//  Created by Pat Butler on 2022-05-05.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
  
  @Published var statistics: [Statistics] = []
  @Published var allCoins: [Coin] = []
  @Published var portfolioCoins: [Coin] = []
  @Published var searchText: String = ""
  @Published var isLoading: Bool = false
  @Published var sortOption: SortOption = .holdings
  
  private let coinDataService = CoinDataService()
  private let marketDataSerice = MarketDataService()
  private let portfolioDataService = PortfolioDataService()
  private var cancellables = Set<AnyCancellable>()
  
  enum SortOption {
    case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
  }
  
  init() {
 		addSubscribers()
  }
  
  // MARK: - INTENTS
  
  func addSubscribers() {
    
    // STEP 1: updates allCoins
    $searchText
      .combineLatest(coinDataService.$allCoins, $sortOption)
      .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
      .map(filterAndSortCoins)
      .sink { [weak self] returnedCoins in
        self?.allCoins = returnedCoins
      }
      .store(in: &cancellables)
    
    // STEP 2: update the portfolioCoins from Core Data
    $allCoins
      .combineLatest(portfolioDataService.$savedEntities)
      .map(mapAllCoinsToPortfolioCoins)
      .sink { [weak self] returnedCoins in
        guard let self = self else { return }
        self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
      }
      .store(in: &cancellables)
  
    
    // STEP 3: update the global market data
    marketDataSerice.$marketData
      .combineLatest($portfolioCoins)
      .map(mapGlobalMarketData)
      .sink { [weak self] (returnedStats) in
        self?.statistics = returnedStats
        self?.isLoading = false
      }
      .store(in: &cancellables)
  }
  
  func updatePortfolio(coin: Coin, amount: Double) {
    portfolioDataService.updatePortfolio(coin: coin, amount: amount)
  }
  
  func reloadData() {
    isLoading = true
    coinDataService.getCoins()
    marketDataSerice.getMarketData()
    HapticManager.notification(type: .success)
  }
  
  private func filterAndSortCoins(text: String, coins: [Coin], sort: SortOption) -> [Coin] {
    var updatedCoins = filterCoins(text: text, coins: coins)
    sortCoins(sort: sort, coins: &updatedCoins)
    return updatedCoins
  }
  
  private func filterCoins(text: String, coins: [Coin]) -> [Coin] {
    guard !text.isEmpty else {
      return coins
    }
    let lowercasedText = text.lowercased()
    
    return coins.filter { (coin) -> Bool in
      return coin.name.lowercased().contains(lowercasedText) ||
      coin.symbol.lowercased().contains(lowercasedText) ||
      coin.id.lowercased().contains(lowercasedText)
      
    }
  }
  
  private func sortCoins(sort: SortOption, coins: inout [Coin]) {
    switch sort {
    case .rank, .holdings:
      coins.sort { $0.rank < $1.rank }
    case .rankReversed, .holdingsReversed:
      coins.sort{ $0.rank > $1.rank }
    case .price:
      coins.sort { $0.currentPrice < $1.currentPrice }
    case .priceReversed:
      coins.sort { $0.currentPrice > $1.currentPrice }
      }
  }
  
  private func sortPortfolioCoinsIfNeeded(coins: [Coin]) -> [Coin] {
    // will only sort by holdings or reversedHoldings if needed
    switch sortOption {
    case .holdings:
      return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue })
    case .holdingsReversed:
      return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue })
    default:
      return coins
    }
  }
  
  private func mapAllCoinsToPortfolioCoins(allCoins: [Coin], portfolioEntities: [PortfolioEntity]) -> [Coin] {
    allCoins
      .compactMap { (coin) -> Coin? in
        guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
         return nil
      }
        return coin.updateHoldings(amount: entity.amount)
      }
  }
  
  private func mapGlobalMarketData(marketData: MarketData?, portfolioCoins: [Coin]) -> [Statistics] {
    var stats: [Statistics] = []
    guard let data = marketData else {
      return stats
    }
    let marketCap = Statistics(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
    let volume = Statistics(title: "24h Volume", value: data.volume)
    let btcDominance = Statistics(title: "BTC Dominance", value: data.btcDominance)
    
    let portfolioValue =
    	portfolioCoins
      	.map { $0.currentHoldingsValue }
        .reduce(0, +)
    
    let previousValue =
    	portfolioCoins
      .map { (coin) -> Double in
        let currentValue = coin.currentHoldingsValue
        let percentChange = (coin.priceChangePercentage24H ?? 0.0) / 100
        let previousValue = currentValue / (1 + percentChange)
        return previousValue
      }
      .reduce(0, +)
    
    let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
    
    let portfolio = Statistics(
      title: "Portfolio Value",
      value: portfolioValue.asCurrencyWith2Decimals(),
      percentageChange: percentageChange
    )
    
    stats.append(contentsOf: [
      marketCap,
      volume,
      btcDominance,
      portfolio
      
    ])
    return stats
  }
}
