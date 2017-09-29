//
//  ProductMainCollectionViewController.swift
//  GoodLife
//
//  Created by JordanLin on 2017/9/28.
//  Copyright © 2017年 JordanLin. All rights reserved.
//

import UIKit

import SDWebImage

class ProductMainCollectionViewController: UICollectionViewController {

    let productManager = ProductManager()
    
    var products = [Product]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        productManager.delegate = self
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        productManager.getProductList(page: 0)
        
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
    
        cell.productImageView.sd_setImage(with: URL(string: products[indexPath.row].imageOriginURLString))
        
        cell.titleLabel.text = products[indexPath.row].title
    
        cell.priceLabel.text = "$ " + String(products[indexPath.row].price)
        
        cell.tag = products[indexPath.row].id
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "toProductDetail":
            
            let cell = sender as! ProductCollectionViewCell
            
            let productID = cell.tag
            
            let productDetailViewController = segue.destination as! ProductDetailViewController
            
            productDetailViewController.productID = productID
            
        default:
            break
        }
    }
}

extension ProductMainCollectionViewController: ProductManagerDelegate {
    
    func didGetProductList(_ manager:ProductManager, didGet products:[Product]) {
        
        self.products = products
    }
    
    func didGetSingleProduct(_ manager:ProductManager, didGet product:Product) {
        
        print(product)
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
