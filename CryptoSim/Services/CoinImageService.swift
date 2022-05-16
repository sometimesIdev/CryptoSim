//
//  CoinImageService.swift
//  CryptoSim
//
//  Created by Pat Butler on 2022-05-06.
//

import SwiftUI
import Combine

class CoinImageSerivce {
  
  @Published var image: UIImage? = nil
  
  private var imageSubscription: AnyCancellable?
  private let coin: Coin
  private let fileManager = LocalFileManager.instance
  private let folderName = "coin_image"
  private let imageName: String
  
  init(coin: Coin) {
    self.coin = coin
    self.imageName = coin.id
    getCoinImage()
   
  }
  
  private func getCoinImage() {
    if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
      image = savedImage
    } else {
      downloadCoinImage()
    }
  }
  
  private func downloadCoinImage() {
    
    guard let url = URL(string: coin.image) else { return }
    
    imageSubscription = NetworkingManager.download(url: url)
      .tryMap({ data -> UIImage? in
        return UIImage(data: data)
      })
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
        guard let self = self, let downloadedImage = returnedImage else { return }
        self.image = downloadedImage
        self.imageSubscription?.cancel()
        self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
      })
  }
}
