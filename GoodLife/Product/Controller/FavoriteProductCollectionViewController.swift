//
//  FavoriteProductCollectionViewController.swift
//  GoodLife
//
//  Created by JordanLin on 2017/9/29.
//  Copyright © 2017年 JordanLin. All rights reserved.
//

import UIKit

import UIScrollView_InfiniteScroll

class FavoriteProductCollectionViewController: UICollectionViewController {

    let productManager = ProductManager()
    
    var page: Int = 1
    
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
        
        collectionView!.addInfiniteScroll { (collectionView) in
            
            collectionView.performBatchUpdates({
                
                self.page += 1
                
                self.productManager.getProductList(page: self.page)
                
            }, completion: { finished in
                collectionView.finishInfiniteScroll()
            })
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        products = []
        
        productManager.getFavoriteProductList(page: page)
        
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return products.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCollectionViewCell", for: indexPath) as! FavoriteCollectionViewCell
    
        cell.productImageView.sd_setImage(with: URL(string: products[indexPath.row].imageOriginURLString))
        
        cell.titleLabel.text = products[indexPath.row].title
        
        cell.priceLabel.text = "$ " + String(products[indexPath.row].price)
    
        cell.tag = products[indexPath.row].id
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "toNoteDetail":
            
            let cell = sender as! FavoriteCollectionViewCell
            
            let productID = cell.tag
            
            let productDetailViewController = segue.destination as! ProductDetailViewController
            
            productDetailViewController.productID = productID
            
            productDetailViewController.mode = .note
            
        default:
            break
        }
    }
}


extension FavoriteProductCollectionViewController: ProductManagerDelegate {
    
    func didGetProductList(_ manager:ProductManager, didGet products:[Product]) {
        
        //print(products)
    }
    
    func didGetSingleProduct(_ manager:ProductManager, didGet product:Product) {
        
        //print(product)
        
    }
    
    func didGetFavoriteList(_ manager:ProductManager, didGet products:[Product]) {
        
        self.products += products
        
    }
    
    func addedFavoriteItem(_ manager: ProductManager, didGet message: String) {
        //print(message)
    }
    
    func removedFavoriteItem(_ manager: ProductManager, didGet message: String) {
        //print(message)
    }
}
