//
//  DetailView.swift
//  CryptoSim
//
//  Created by Pat Butler on 2022-05-10.
//

import SwiftUI

struct DetailLoadingView: View {
  
  @Binding var coin: Coin?
  
  var body: some View {
    ZStack {
      if let coin = coin {
        DetailView(coin: coin)
      }
    }
  }
}

struct DetailView: View {
  
  @StateObject private var vm: DetailViewModel
  @State private var showFullDescription: Bool = false
  
  private var columns: [GridItem] = [
    GridItem(.flexible()),
    GridItem(.flexible())
  ]
  private let columnSpacing: CGFloat = 30
  
  init(coin: Coin) {
    _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
  }
    var body: some View {
      ScrollView {
        VStack {
          ChartView(coin: vm.coin)
            .padding(.vertical)
          
          VStack(spacing: 20) {
            overviewTitle
            Divider()
            descriptionSection
            overviewGrid
            additionalTitle
            Divider()
            additionalGrid
            websiteLinks
          }
          .padding()
        }
      }
      .background(
        Color.theme.background
          .ignoresSafeArea()
      )
      .navigationTitle(vm.coin.name)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          navigationBarTrailingItems
          
        }
      }
    }
}

extension DetailView {
  private var overviewTitle: some View {
    Text("Overview")
      .font(.title)
      .bold()
      .foregroundColor(.theme.accent)
      .frame(maxWidth: .infinity, alignment: .leading)
  }
  private var additionalTitle: some View {
    Text("Additional Details")
      .font(.title)
      .bold()
      .foregroundColor(.theme.accent)
      .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  private var descriptionSection: some View {
    ZStack {
      if let coinDescription = vm.coinDescription, !coinDescription.isEmpty {
        VStack(alignment: .leading) {
          Text(coinDescription)
            .lineLimit(showFullDescription ? nil : 3)
          Button {
            withAnimation(.easeInOut) {
              showFullDescription.toggle()
            }
          } label: {
            Text(showFullDescription ? "Read less..." : "Read more...")
              .font(.caption)
              .fontWeight(.bold)
              .accentColor(.blue)
              .padding(.vertical, 4)
          }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
      }
      
    }
  }
  private var overviewGrid: some View {
    LazyVGrid(
      columns: columns,
      alignment: .leading,
      spacing: columnSpacing,
      pinnedViews: [],
      content: {
        ForEach(vm.overviewStatistics) { stat in
          StatisticView(stat: stat)
        }
      })
  }
  private var additionalGrid: some View {
    LazyVGrid(
      columns: columns,
      alignment: .leading,
      spacing: columnSpacing,
      pinnedViews: [],
      content: {
        ForEach(vm.additionalStatistics) { stat in
          StatisticView(stat: stat)
        }
      })
  }
  private var navigationBarTrailingItems: some View {
    HStack {
      Text(vm.coin.symbol.uppercased())
        .font(.headline)
      .foregroundColor(.theme.secondaryText)
      CoinImageView(coin: vm.coin)
        .frame(width: 25, height: 25)
    }
  }
  
  private var websiteLinks: some View {
    HStack {
      Spacer()
      if let websiteString = vm.websiteURL,
         let url = URL(string: websiteString) {
        Link("Website", destination: url)
      }
      Spacer()
      if let redditString  = vm.redditURL,
         let url = URL(string: redditString) {
        Link("Reddit", destination: url)
      }
      Spacer()
    }
    .accentColor(.blue)
    .frame(maxWidth: .infinity, alignment: .leading)
    .font(.headline)
  }
  
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
      NavigationView {
        DetailView(coin: dev.coin)
      }
    }
}
