//
//  ProductMainCollectionViewController.swift
//  GoodLife
//
//  Created by JordanLin on 2017/9/28.
//  Copyright © 2017年 JordanLin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

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
        
        productManager.getProductList(page: 0)

    }

    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
    
        cell.titleLabel.text = products[indexPath.row].title
    
        return cell
    }

}

extension ProductMainCollectionViewController: ProductManagerDelegate {
    
    func didGetProductList(_ manager:ProductManager, didGet products:[Product]) {
        
        print(products)
        
        print("count: ", products.count)
        
        self.products = products
    }
    
}
