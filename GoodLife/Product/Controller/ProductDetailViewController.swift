//
//  ProductDetailViewController.swift
//  GoodLife
//
//  Created by JordanLin on 2017/9/29.
//  Copyright © 2017年 JordanLin. All rights reserved.
//

import UIKit

enum DetailMode {
    
    case normal, note
    
}

enum ButtonTitle {
    
    case addedToNote, removedFromNote
    
    var string: String {
        
        switch self {
            
        case .addedToNote:
            return "Add to note"

        case .removedFromNote:
            return "Remove from Note"
            
        }
    }
}

class ProductDetailViewController: UIViewController {

    var productID: Int?
    
    var mode: DetailMode = .normal
    
    let productManager = ProductManager()
    
    @IBOutlet var productImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var storeNameLabel: UILabel!
    
    @IBOutlet var salesCountLabel: UILabel!
    
    @IBOutlet var contentLabel: UILabel!
    
    @IBOutlet var noteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        productManager.delegate = self
        
        productManager.getSingleProduct(productId: productID!)
        
        setUpNoteButton()
        
    }

    func setUpNoteButton() {
        
        noteButton.titleLabel?.textColor = .blue
        switch mode {
            
        case .normal:
            noteButton.setTitle(ButtonTitle.addedToNote.string, for: .normal)
            
        case .note:
            noteButton.setTitle(ButtonTitle.removedFromNote.string, for: .normal)
            
        }
        
    }
    
    @IBAction func addToNoteButtonTapped(_ sender: UIButton) {
        
        let title = (sender.titleLabel?.text)!
        
        switch title {

        case ButtonTitle.addedToNote.string:
            noteButton.setTitle(ButtonTitle.addedToNote.string, for: .normal)
            productManager.addProductIntoFavoriteList(productId: productID!)

        case ButtonTitle.removedFromNote.string:
            noteButton.setTitle(ButtonTitle.removedFromNote.string, for: .normal)
            productManager.removeProductFromFavoriteList(productId: productID!)

        default:
            break
            
        }
    }
}

extension ProductDetailViewController: ProductManagerDelegate {
    
    func didGetProductList(_ manager:ProductManager, didGet products:[Product]) {
        
        //print(products)
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
        
        //print(products)
    }
    
    func addedFavoriteItem(_ manager: ProductManager, didGet message: String) {
        
        let alertController = UIAlertController(title: "Note list", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
        
        noteButton.setTitle(ButtonTitle.removedFromNote.string, for: .normal)
    }
    
    func removedFavoriteItem(_ manager: ProductManager, didGet message: String) {
        let alertController = UIAlertController(title: "Note list", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
        
        noteButton.setTitle(ButtonTitle.addedToNote.string, for: .normal)
    }
}

