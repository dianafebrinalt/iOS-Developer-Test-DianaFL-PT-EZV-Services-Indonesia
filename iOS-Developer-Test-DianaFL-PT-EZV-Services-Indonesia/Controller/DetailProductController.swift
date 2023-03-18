//
//  DetailProductController.swift
//  iOS-Developer-Test-DianaFL-PT-EZV-Services-Indonesia
//
//  Created by Diana Febrina Lumbantoruan on 18/03/23.
//

import UIKit

class DetailProductController: UIViewController {
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var productImageCollectionView: UICollectionView!
    @IBOutlet weak var stocksLabel: UILabel!
    @IBOutlet weak var productshumbnail: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var discLabel: UILabel!
    
    var productsName = ""
    var productDiscount = ""
    var productDescription = ""
    var thumbnailImage: String?
    var productPrice = ""
    var productStock = ""
    var listImageProduct: [String] = []
    private var thumbnailUrl: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDataDetailProduct()
    }
    
    func setDataDetailProduct() {
        productName.text = productsName
        descLabel.text = productDescription
        priceLabel.text = productPrice
        stocksLabel.text = productStock
        
        guard let thumbnail = thumbnailImage else {return}
        thumbnailUrl = thumbnail
        guard let thumbnailURL = URL(string: thumbnailUrl) else {
            self.productshumbnail.image = UIImage(systemName: "iphone.gen1")
            return
        }
        
        // Before we download the image we clear out the old one
        self.productshumbnail.image = nil
        
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
                    self.productshumbnail.image = image
                }
            }
        }
        task.resume()
    }
}
