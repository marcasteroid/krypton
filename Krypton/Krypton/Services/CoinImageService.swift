//
//  CoinImageService.swift
//  Krypton
//
//  Created by Marco Margarucci on 09/09/23.
//

import Foundation
import SwiftUI
import Combine

final class CoinImageService {
    
    @Published var image: UIImage? = nil
    private var imageSubscription: AnyCancellable?
    private let coin: Coin
    private let localFileManager = LocalFileManager.instance
    private let folderName = CoinImageServiceConstants.imageFolderName
    private let imageName: String
    
    init(coin: Coin) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = localFileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
            debugPrint("[DEBUG]: Retrieved image from file manager")
        } else {
            downloadCoinImage()
            debugPrint("[DEBUG]: Download image")
        }
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] returnedImage in
                guard let self = self, let downloadedImage = returnedImage else { return }
                self.image = returnedImage
                self.imageSubscription?.cancel()
                self.localFileManager.saveImage(image: downloadedImage,
                                                imageName: self.imageName,
                                                folderName: self.folderName)
            })
    }
}
