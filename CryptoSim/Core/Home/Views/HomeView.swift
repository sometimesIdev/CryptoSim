//
//  HomeView.swift
//  CryptoSim
//
//  Created by Pat Butler on 2022-05-05.
//

import SwiftUI

// this view sits inside of a Navigation View in the CryptoSimApp
struct HomeView: View {
  
  // MARK: - PROPERTIES
  
  @EnvironmentObject private var vm: HomeViewModel
  @State private var showPortfolio: Bool = false //animate right
  @State private var showPortfolioView: Bool = false // show new sheet
  @State private var showSettingsView: Bool = false // show settings sheet
  @State private var selectedCoin: Coin? = nil
  @State private var showDetailView: Bool = false
 
  
  
  // MARK: - BODY
  
  var body: some View {
    ZStack {
      
      // background layer
      Color.theme.background
        .ignoresSafeArea()
        .sheet(isPresented: $showPortfolioView) {
          PortfolioView()
            .environmentObject(vm)
        }
      
      //content layer
      VStack {
        homeHeader
        HomeStatsView(showPortfolio: $showPortfolio)
        SearchBarView(searchText: $vm.searchText)
        
        columnTitles
        
        if !showPortfolio {
          allCoinsList
            .transition(.move(edge: .leading))
        }
        
        if showPortfolio {
          ZStack(alignment: .top) {
            if vm.portfolioCoins.isEmpty && vm.searchText.isEmpty {
              portfolioMessage
            } else {
              portfolioCoinsList
            }
          }
          .transition(.move(edge: .trailing))
        }
        
        Spacer(minLength: 0)
      }
      .sheet(isPresented: $showSettingsView) {
        SettingsView()
        
      }
    }
    .background(
    	NavigationLink(
        isActive: $showDetailView,
        destination: {
          DetailLoadingView(coin: $selectedCoin)
        },
        label: { EmptyView() })
    )
  }
  
  // MARK: - COMPLEX PROPERTIES
  
  private var homeHeader: some View {
    HStack {
      CircleButtonView(iconName: showPortfolio ? "plus" : "info")
        .animation(.none, value: showPortfolio)
        .onTapGesture {
          if showPortfolio {
            showPortfolioView.toggle()
          } else {
            showSettingsView.toggle()
          }
        }
        .background(
          CircleButtonAnimationView(animate: $showPortfolio)
        )
      Spacer()
      Text(showPortfolio ? "Portfolio" : "Live Prices")
        .font(.headline)
        .fontWeight(.heavy)
        .foregroundColor(Color.theme.accent)
        .animation(.none, value: showPortfolio)
      Spacer()
      CircleButtonView(iconName: "chevron.right")
        .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
        .onTapGesture {
          withAnimation(.spring()) {
            showPortfolio.toggle()
          }
        }
    }
    .padding(.horizontal)
  }
  
  private var allCoinsList: some View {
    List(vm.allCoins) { coin in
      CoinRowView(coin: coin, showHoldingsColumn: false)
        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
        .onTapGesture {
          segue(coin: coin)
        }
        .listRowBackground(Color.theme.background)
    }
    .listStyle(.plain)
    .refreshable {
      withAnimation(.linear(duration: 2.0)) {
        vm.reloadData()
      }
    }
  }
  
  private var portfolioMessage: some View {
    Text("You haven't added any coins to your portfolio yet! Click on the + button to get started. 🧐")
      .font(.callout)
      .fontWeight(.medium)
      .foregroundColor(.theme.accent)
      .multilineTextAlignment(.center)
      .padding(50)
  }
  
  private var portfolioCoinsList: some View {
    List(vm.portfolioCoins) { coin in
      LazyHStack {
        CoinRowView(coin: coin, showHoldingsColumn: true)
          .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
          .onTapGesture {
            segue(coin: coin)
          }
          .listRowBackground(Color.theme.background)

      }
    }
    .listStyle(.plain)
    .refreshable {
      withAnimation(.linear(duration: 2.0)) {
        vm.reloadData()
      }
    }
  }
  
  private func segue(coin: Coin) {
    selectedCoin = coin
    showDetailView.toggle()
  }
  
  private var columnTitles: some View {
    HStack {
      HStack {
        Text("Coin")
        Image(systemName: "chevron.down")
          .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0)
          .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
      }
      .onTapGesture {
        vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
      }
      Spacer()
      if showPortfolio {
        HStack {
          Text("Holdings")
          Image(systemName: "chevron.down")
            .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
        }
        .onTapGesture {
          vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
        }
      }
      HStack {
        Text("Price")
        Image(systemName: "chevron.down")
          .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
      }
      .onTapGesture {
        vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
      }
      .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
    .font(.caption)
    .foregroundColor(.theme.secondaryText)
    .padding(.horizontal)
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      HomeView()
        .navigationBarHidden(true)
    }
    .environmentObject(dev.homeVM)
    
  }
}
