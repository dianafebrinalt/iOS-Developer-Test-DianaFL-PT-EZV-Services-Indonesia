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
    @IBOutlet weak var discLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    var productsName = ""
    var productDiscount = ""
    var productDescription = ""
    var thumbnailImage = ""
    var productPrice = ""
    var productStock = ""
    var productRating = ""
    var listImageProduct: [String] = []
    private var thumbnailUrl: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDataDetailProduct()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        productImageCollectionView.dataSource = self
        productImageCollectionView.delegate = self
    }
    
    func setDataDetailProduct() {
        productNameLabel.text = productsName
        descLabel.text = productDescription
        priceLabel.text = "$ \(productPrice)"
        stocksLabel.text = "Stock only : \(productStock)"
        ratingLabel.text = "Rating for this product : \(productRating)"
        
        guard let thumbnailURL = URL(string: thumbnailImage) else {
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
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension DetailProductController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listImageProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailCollectionCell", for: indexPath) as! DetailCollectionCell
        
        let images = listImageProduct[indexPath.item]
        cell.setProductImage(image: images)
        return cell
    }
}
