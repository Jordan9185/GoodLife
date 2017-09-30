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
    
    func didGetSingleProduct(_ manager:ProductManager, didGet product:Product)
    
    func didGetFavoriteList(_ manager:ProductManager, didGet products:[Product])
    
    func addedFavoriteItem(_ manager:ProductManager, didGet message:String)
    
    func removedFavoriteItem(_ manager:ProductManager, didGet message:String)
}

class ProductManager {
    
    static let shared = ProductManager()
    
    weak var delegate: ProductManagerDelegate?
    
    let apiVersion = 2
    
    let typeSimplifiedId = 1
    
    let testAPI = "ad7c2d5ffa8f06d46b895dafbd409562"
    
    func getProductList(page: Int) {
        
        var products: [Product] = []
        
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
                        
                        products.append(
                            try! Product(dataDictionary: data)
                        )
                        
                    })

                    self.delegate?.didGetProductList(self, didGet: products)
                    
                }
                
            }
            
        }.resume()
        
    }
    
    func getSingleProduct(productId: Int){
        
        let urlString = "\(productListURLString)/\(productId)?api_version=\(apiVersion)&key=\(testAPI)"
        
        let url = URL(string: urlString)
        
        let request = URLRequest(url: url!)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                
                //error handling
                
                return
            }
            
            if let json = try? JSONSerialization.jsonObject(with: data!, options: []) {
                
                if let data = json as? [String:Any] {
                    
                    let product = try! Product(dataDictionary: data)

                    self.delegate?.didGetSingleProduct(self, didGet: product)
                    
                }
                
            }
            
            }.resume()

    }

    func getFavoriteProductList(page: Int) {
        
        var products: [Product] = []
        
        let urlString = "\(favoriteListURLString)/index_of_topic?api_version=\(apiVersion)&key=\(testAPI)&page=\(page)"
        
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        
        let token = UserDefaults.standard.object(forKey: "accessToken") as! String
        
        request.allHTTPHeaderFields = ["Authorization": "Bearer \(token)"]
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                
                //error handling
                
                return
            }
            
            if let json = try? JSONSerialization.jsonObject(with: data!, options: []) {
                
                if let datas = json as? [[String:Any]] {
                    
                    datas.forEach({ (data) in
                        
                        products.append(
                            try! Product(dataDictionary: data)
                        )
                        
                    })
                    
                    self.delegate?.didGetFavoriteList(self, didGet: products)
                    
                }
                
            }
            
            }.resume()
    }
    
    func addProductIntoFavoriteList(productId: Int) {
        
        let urlString = "\(favoriteListURLString)?topic_id=\(productId)&key=\(testAPI)"
        
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        
        let token = UserDefaults.standard.object(forKey: "accessToken") as! String

        request.httpMethod = "POST"
        
        request.allHTTPHeaderFields = ["Authorization": "Bearer \(token)"]
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                
                //error handling
                
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                
                switch httpResponse.statusCode {
                    
                case 200:
                    self.delegate?.addedFavoriteItem(self, didGet: "Item already exist.")
                case 201:
                    self.delegate?.addedFavoriteItem(self, didGet: "Item added successfully.")
                default:
                    break
                }
                
            }

        }.resume()

    }
    
    func removeProductFromFavoriteList(productId: Int) {
        
        let urlString = "\(favoriteListURLString)?topic_id=\(productId)&key=\(testAPI)"
        
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        
        let token = UserDefaults.standard.object(forKey: "accessToken") as! String
        
        request.httpMethod = "DELETE"
        
        request.allHTTPHeaderFields = ["Authorization": "Bearer \(token)"]
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                
                //error handling
                
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                
                switch httpResponse.statusCode {
                    
                case 200:
                    self.delegate?.removedFavoriteItem(self, didGet: "Item removed successfully.")
                    
                default:
                    break
                }
                
            }
            
            }.resume()

    }
}
