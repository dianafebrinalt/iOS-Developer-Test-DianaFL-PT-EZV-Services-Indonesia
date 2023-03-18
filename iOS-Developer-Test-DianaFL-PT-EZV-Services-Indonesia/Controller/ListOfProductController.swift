//
//  ViewController.swift
//  iOS-Developer-Test-DianaFL-PT-EZV-Services-Indonesia
//
//  Created by Diana Febrina Lumbantoruan on 18/03/23.
//

import UIKit

class ListOfProductController: UIViewController {

    @IBOutlet weak var listOfProductTableView: UITableView!
    
    let viewModelProduct = ProductViewModel()
    var products : [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        getListOfProduct()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        listOfProductTableView.reloadData()
    }
    
    func registerTableView() {
        listOfProductTableView.register(UINib(nibName: "ListProductTableCell", bundle: nil), forCellReuseIdentifier: "listProductCell")
        listOfProductTableView.delegate = self
        listOfProductTableView.dataSource = self
    }
    
    func getListOfProduct() {
        viewModelProduct.getDataProduct { [weak self] productsData in
            
            switch productsData {
                case .success(let data):
                    self?.products = data.products
                    self?.listOfProductTableView.reloadData()
                case .failure(let error):
                    print("Error while fetch data product from api")
            }
        }
    }
}

extension ListOfProductController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listProductCell", for: indexPath) as! ListProductTableCell
        let product = products[indexPath.item]
        cell.product = product
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension ListOfProductController: ListProductTableCellDelegate {
    func goToProductDetail(name: String, description: String, discount: String, thumbnail: String, price: String, stock: String, rating: String, imagesProduct: [String]) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailProductController") as! DetailProductController
        vc.thumbnailImage = thumbnail
        vc.productStock = stock
        vc.productsName = name
        vc.productDescription = description
        vc.listImageProduct = imagesProduct
        vc.productPrice = price
        vc.productRating = rating
        vc.productDiscount = discount
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}
