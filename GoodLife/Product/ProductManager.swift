//
//  ProductManager.swift
//  GoodLife
//
//  Created by JordanLin on 2017/9/28.
//  Copyright © 2017年 JordanLin. All rights reserved.
//

import Foundation

//{
//    "id": 876211,
//    "company_name": "17Life",
//    "title": "尊爵天際大飯店─翼 日本料理-鮭魚卵主題豪華套餐",
//    "sales_count": 912,
//    "price": 880,
//    "store_name": "尊爵天際大飯店─翼 日本料理",
//    "content": "尊爵天際大飯店─翼 日本料理-鮭魚卵主題豪華套餐",
//    "link": "http://buy.igoodtravel.com/go/876211/bt?via=app",
//    "image": "https://s3-dev.goodlife.tw/system/bt/000/876/211/images/mobile_1506314192.jpg",
//    "image_small": "https://s3-dev.goodlife.tw/system/bt/000/876/211/images/mobile_small_1506314192.jpg",
//    "image_original": "https://s3-dev.goodlife.tw/system/bt/000/876/211/images/1506314192.jpg",
//    "addresses": [
//    {
//    "address": {
//    "address": "桃園市蘆竹區南崁路1段108號",
//    "lat": "25.05197",
//    "lng": "121.28819"
//    }
//    }
//    ]
//}

struct Product {
    
    let id: Int
    let companyName: String
    let title: String
    let salesCount: Int
    let price: Int
    let storeName: String
    let content: String
    let link: String
    let imageURLString: String
    let imageSmallURLString: String
    let imageOriginURLString: String
    let addresses: [String:[String:String]]
    
}

class ProductManager {
    
    static let shared = ProductManager()
    
//    GET http://api.igoodtravel.com/buy/topics
//
//    url params:
//    api_version=2
//    key=[API key]
//    type_simplified_id=1
//    page=[page]
//
//    response: JSON array
    
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
                
                print(json)
                
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
