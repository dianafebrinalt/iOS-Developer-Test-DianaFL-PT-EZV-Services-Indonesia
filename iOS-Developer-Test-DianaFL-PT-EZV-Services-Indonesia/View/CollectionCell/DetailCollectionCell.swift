//
//  DetailCollectionCell.swift
//  iOS-Developer-Test-DianaFL-PT-EZV-Services-Indonesia
//
//  Created by Diana Febrina Lumbantoruan on 18/03/23.
//

import UIKit

class DetailCollectionCell: UICollectionViewCell {
    @IBOutlet weak var imageProduct: UIImageView!
    
    func setProductImage(image: String) {
        guard let thumbnailURL = URL(string: image) else {
            self.imageProduct.image = UIImage(systemName: "iphone.gen1")
            return
        }
        
        // Before we download the image we clear out the old one
        self.imageProduct.image = nil
        
        getProductThumbnail(url: thumbnailURL)
    }
    
    func getProductThumbnail(url: URL) {
        let task = URLSession.shared.dataTask(with: url){ data, response, error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
                return
            }
            
            guard let data = data else{
                print("The Data is Empty")
                return
            }
            
            DispatchQueue.main.async{
                if let image = UIImage(data: data) {
                    self.imageProduct.image = image
                }
            }
        }
        task.resume()
    }
}
