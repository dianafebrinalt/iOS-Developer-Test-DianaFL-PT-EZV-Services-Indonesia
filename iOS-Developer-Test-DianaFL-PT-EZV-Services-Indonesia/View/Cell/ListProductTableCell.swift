//
//  ListProductTableCell.swift
//  iOS-Developer-Test-DianaFL-PT-EZV-Services-Indonesia
//
//  Created by Diana Febrina Lumbantoruan on 18/03/23.
//

import UIKit

protocol ListProductTableCellDelegate: AnyObject {
    func goToProductDetail()
}

class ListProductTableCell: UITableViewCell {
    private var thumbnailUrl: String = ""
    var delegate : ListProductTableCellDelegate?
    var product : Product? {
        didSet {
            guard let product = product else { return }
            setCellWithValuesOf(product)
        }
    }

    @IBOutlet weak var productThumbnail: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var detailButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        detailButton.addTarget(self, action: #selector(goToDetailPage), for: .touchUpInside)
    }
    
    func setCellWithValuesOf(_ product : Product) {
        setDataProduct(productName: product.title, productDescription: product.description, thumbnail: product.thumbnail)
    }

    private func setDataProduct(productName: String?, productDescription: String?, thumbnail: String?) {
        productNameLabel.text = productName
        productDescriptionLabel.text = productDescription
        
        guard let thumbnail = thumbnail else {return}
        thumbnailUrl = thumbnail
        
        guard let thumbnailURL = URL(string: thumbnailUrl) else {
            self.productThumbnail.image = UIImage(systemName: "iphone.gen1")
            return
        }
        
        // Before we download the image we clear out the old one
        self.productThumbnail.image = nil
        
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
                    self.productThumbnail.image = image
                }
            }
        }
        task.resume()
    }
    
    @objc func goToDetailPage() {
        print("BERHASIL")
        delegate?.goToProductDetail()
    }
    
}
