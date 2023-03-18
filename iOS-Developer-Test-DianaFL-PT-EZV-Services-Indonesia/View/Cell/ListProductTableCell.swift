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

    @IBOutlet weak var productThumbnail: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var detailButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData() {
        productThumbnail.image = UIImage(systemName: "pencil")
        productNameLabel.text = "HP OPPO"
        productDescriptionLabel.text = "Good condition"
        detailButton.addTarget(self, action: #selector(goToDetailPage), for: .touchUpInside)
    }
    
    @objc func goToDetailPage() {
        print("BERHASIL")
        delegate?.goToProductDetail()
    }
    
}
