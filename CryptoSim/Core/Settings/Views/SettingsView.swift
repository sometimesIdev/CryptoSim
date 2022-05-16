//
//  SettingsView.swift
//  CryptoSim
//
//  Created by Pat Butler on 2022-05-12.
//

import SwiftUI

struct SettingsView: View {
 
  let defaultURL = URL(string: "https://www.google.com")!
  let youtubeURL = URL(string: "https://www.youtube.com/c/swiftfulthinking")!
  let coffeeURL = URL(string: "https://www.buymeacoffee.com/nicksarno")!
  let coinGeckoURL = URL(string: "https://www.coingecko.com")!
  let personalURL = URL(string: "https://www.thoughtbubble.io")!
  
 
  
    var body: some View {
      NavigationView {
        ZStack {
          // background layer
          Color.theme.background
            .ignoresSafeArea()
          
          //content layer
          List {
            swiftfulThinkingSection
              .listRowBackground(Color.theme.background.opacity(0.5))
            coinGeckoSection
              .listRowBackground(Color.theme.background.opacity(0.5))
            developerSection
              .listRowBackground(Color.theme.background.opacity(0.5))
            applicationSection
              .listRowBackground(Color.theme.background.opacity(0.5))
          }
        }
        
        .font(.headline)
        .accentColor(.blue)
        .listStyle(GroupedListStyle())
        .navigationTitle("Settings")
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            XMarkButton()
          
          }
        }
      }
    }
}

extension SettingsView {
  
  private var swiftfulThinkingSection: some View {
    Section {
      VStack(alignment: .leading) {
        Image("logo")
          .resizable()
          .frame(width: 100, height: 100)
          .clipShape(RoundedRectangle(cornerRadius: 20))
        Text("This app was made as an excercise in SwiftUI, Combine and Core Data, using MVVM architecture based on an old youtube video.")
          .font(.callout)
          .fontWeight(.medium)
          .foregroundColor(.theme.accent)
      }
      .padding(.vertical)
      Link("Subscribe on Youtube 🥳", destination: youtubeURL)
      Link("Buy the video creator a coffee ☕️", destination: coffeeURL)
    } header: {
      Text("Swiftful Thinking")
    }
  }
  
  private var coinGeckoSection: some View {
    Section {
      VStack(alignment: .leading) {
        Image("coingecko")
          .resizable()
          .scaledToFit()
          .frame(height: 100)
          .clipShape(RoundedRectangle(cornerRadius: 20))
        Text("The cryptocurrency data that is used in this app comes from a free API supplied by CoinGecko! Coin prices are not realtime under the free plan.")
          .font(.callout)
          .fontWeight(.medium)
          .foregroundColor(.theme.accent)
      }
      .padding(.vertical)
      Link("Visit CoinGecko", destination: coinGeckoURL)
      } header: {
      Text("Coin Gecko")
    }
  }
  
  private var developerSection: some View {
    Section {
      VStack(alignment: .leading) {
        Image("thoughtbubble2color")
          .resizable()
          .scaledToFit()
          .frame(height: 100)
          .clipShape(RoundedRectangle(cornerRadius: 20))
        Text("Hi! My name is Pat Butler. I developed this app for demonstrative purposes and furthering my skillset with modern multithreaded advanced apple API's noted in the top section.")
          .font(.callout)
          .fontWeight(.medium)
          .foregroundColor(.theme.accent)
      }
      .padding(.vertical)
      Link("Visit developer website", destination: personalURL)
      } header: {
      Text("Thoughtbubble.io")
    }
  }
  
  private var applicationSection: some View {
    Section {
      Link("Terms of Service", destination: defaultURL)
      Link("Privacy Policy", destination: defaultURL)
      Link("Company Website", destination: defaultURL)
      Link("Learn More", destination: defaultURL)
    } header: {
      Text("Application")
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
      SettingsView()
    }
}
