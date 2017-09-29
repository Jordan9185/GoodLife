//
//  ProductDetailViewController.swift
//  GoodLife
//
//  Created by JordanLin on 2017/9/29.
//  Copyright © 2017年 JordanLin. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {

    var productID: Int?
    
    let productManager = ProductManager()
    
    @IBOutlet var productImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var storeNameLabel: UILabel!
    
    @IBOutlet var salesCountLabel: UILabel!
    
    @IBOutlet var contentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        productManager.delegate = self
        
        productManager.getSingleProduct(productId: productID!)
        
    }

    @IBAction func addToNoteButtonTapped(_ sender: UIButton) {
        
        productManager.addProductIntoFavoriteList(productId: productID!)
    }
}

extension ProductDetailViewController: ProductManagerDelegate {
    
    func didGetProductList(_ manager:ProductManager, didGet products:[Product]) {
        
        print(products)
    }
    
    func didGetSingleProduct(_ manager:ProductManager, didGet product:Product) {
        
        DispatchQueue.main.async {
            
            self.productImageView.sd_setImage(with: URL(string: product.imageOriginURLString), completed: nil)
            
            self.titleLabel.text = product.title
            
            self.storeNameLabel.text = product.storeName
            
            self.salesCountLabel.text = "Sold: " + String(product.salesCount)
            
            self.contentLabel.text = product.content
            
        }

    }
    
    func didGetFavoriteList(_ manager:ProductManager, didGet products:[Product]) {
        
        print(products)
    }
    
    func addedFavoriteItem(_ manager: ProductManager, didGet message: String) {
        print(message)
    }
    
    func removedFavoriteItem(_ manager: ProductManager, didGet message: String) {
        print(message)
    }
}

