//
//  LocalFileManager.swift
//  CryptoSim
//
//  Created by Pat Butler on 2022-05-06.
//

import SwiftUI

class LocalFileManager {
  
  static let instance = LocalFileManager()
  
  private init() {}
  
  func saveImage(image: UIImage, imageName: String, folderName: String) {
    
    // create a local folder if needed to store downloaded images
    createFolderIfNeeded(folderName: folderName)
    
    // get a path url for the image to store
    guard
      let data = image.pngData(),
    	let url = getURLForImage(imageName: imageName, folderName: folderName)
    else { return }
		
    // save image to the local folder url
    do {
      try data.write(to: url)
    } catch let error {
      print("Error saving image: ImageName: \(imageName). \(error.localizedDescription)")
    }
  }
  
  func getImage(imageName: String, folderName: String) -> UIImage? {
    guard
      let url = getURLForImage(imageName: imageName, folderName: folderName),
      FileManager.default.fileExists(atPath: url.path) else {
      return nil
    }
    return UIImage(contentsOfFile: url.path)
  }
  
  private func createFolderIfNeeded(folderName: String) {
    guard let url = getURLforFolder(folderName: folderName) else { return }
    
    if !FileManager.default.fileExists(atPath: url.path) {
      do {
        try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
      } catch let error {
        print("Error creating directory, Foldername: \(folderName). \(error)")
      }
    }
  }
  
  private func getURLforFolder(folderName: String) -> URL? {
    guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
      return nil
    }
    return url.appendingPathComponent(folderName)
  }
  
  private func getURLForImage(imageName: String, folderName: String) -> URL? {
    guard let folderURL = getURLforFolder(folderName: folderName) else {
      return nil
    }
    return folderURL.appendingPathComponent(imageName + ".png")
  }
}
