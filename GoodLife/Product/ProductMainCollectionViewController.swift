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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        productManager.delegate = self
        productManager.getProductList(page: 0)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }

}

extension ProductMainCollectionViewController: ProductManagerDelegate {
    
    func didGetProductList(_ manager:ProductManager, didGet products:[Product]) {
        
        print(products)
        
        print("count: ", products.count)
    }
    
}
