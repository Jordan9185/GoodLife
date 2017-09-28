//
//  ProductManager.swift
//  GoodLife
//
//  Created by JordanLin on 2017/9/28.
//  Copyright © 2017年 JordanLin. All rights reserved.
//

import Foundation

protocol ProductManagerDelegate: class {
    
    func didGetProductList(_ manager:ProductManager, didGet products:[Product])
    
}

class ProductManager {
    
    static let shared = ProductManager()
    
    weak var delegate: ProductManagerDelegate?
    
    func getProductList(page: Int) -> [Product] {
        
        var products: [Product] = []
        
        let apiVersion = 2
        
        let typeSimplifiedId = 1
        
        let testAPI = "ad7c2d5ffa8f06d46b895dafbd409562"
        
        let urlString = "\(productListURLString)?api_version=\(apiVersion)&key=\(testAPI)&type_simplified_id=\(typeSimplifiedId)&page=\(page)"
        
        let url = URL(string: urlString)
        
        let request = URLRequest(url: url!)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                
                //error handling
                
                return
            }
            
            if let json = try? JSONSerialization.jsonObject(with: data!, options: []) {
                
                if let datas = json as? [[String:Any]] {
                    
                    datas.forEach({ (data) in
                        
                        guard let id = data["id"] as? Int else {
                            
                            //error handling
                            return
                        }
                        
                        guard let companyName = data["company_name"] as? String else {
                            
                            //error handling
                            return
                        }
                        
                        guard let title = data["title"] as? String else {
                            
                            //error handling
                            return
                        }
                        
                        guard let salesCount = data["sales_count"] as? Int else {
                            
                            //error handling
                            return
                        }
                        
                        guard let price = data["price"] as? Int else {
                            
                            //error handling
                            return
                        }
                        
                        guard let storeName = data["store_name"] as? String else {
                            
                            //error handling
                            return
                        }
                        
                        guard let content = data["content"] as? String else {
                            
                            //error handling
                            return
                        }
                        
                        guard let link = data["link"] as? String else {
                            
                            //error handling
                            return
                        }
                        
                        guard let imageURLString = data["image"] as? String else {
                            
                            //error handling
                            return
                        }
                        
                        guard let imageSmallURLString = data["image_small"] as? String else {
                            
                            //error handling
                            return
                        }
                        
                        guard let imageOriginURLString = data["image_original"] as? String else {
                            
                            //error handling
                            return
                        }
                        
                        guard let addresses = data["addresses"] as? [[String:Any]] else {
                            
                            //error handling
                            return
                        }
                        
                        products.append(
                            Product(id: id,
                                    companyName: companyName,
                                    title: title,
                                    salesCount: salesCount,
                                    price: price,
                                    storeName: storeName,
                                    content: content,
                                    link: link,
                                    imageURLString: imageURLString,
                                    imageSmallURLString: imageSmallURLString,
                                    imageOriginURLString: imageOriginURLString,
                                    addresses: addresses)
                        )
                        
                    })

                    self.delegate?.didGetProductList(self, didGet: products)
                    
                }
                
            }
            
        }.resume()
        
        return products
    }
    
//    func getSingleProduct(productId: Int) -> Product {
//        var product = Product
//
//        return product
//    }
//
    func getFavoriteProductList(page: Int) -> [Product] {
        var products: [Product] = []
        
        return products
    }
    
    func addProductIntoFavoriteList(productId: Int) -> Int {
        var statusCode = 200
        
        return statusCode
    }
    
    func removeProductFromFavoriteList(productId: Int) -> Int {
        var statusCode = 200
        
        return statusCode
    }
}
