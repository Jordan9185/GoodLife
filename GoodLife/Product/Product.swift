//
//  Product.swift
//  GoodLife
//
//  Created by JordanLin on 2017/9/28.
//  Copyright © 2017年 JordanLin. All rights reserved.
//

import Foundation

enum ProductInitError: Error {

    case idFail, companyNameFail, titleFail
    case salesCountFail, priceFail, storeNameFail
    case contentFail, linkFail, imageURLStringFail
    case imageSmallURLStringFail, imageOriginURLStringFail, addressesFail
}

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
    let addresses: [[String:Any]]
    
    init (dataDictionary: [String:Any]) throws {
        
        
        guard let id = dataDictionary["id"] as? Int else {
            throw ProductInitError.idFail
        }
        
        guard let companyName = dataDictionary["company_name"] as? String else {
            throw ProductInitError.idFail
        }
        
        guard let title = dataDictionary["title"] as? String else {
            throw ProductInitError.companyNameFail
        }
        
        guard let salesCount = dataDictionary["sales_count"] as? Int else {
            throw ProductInitError.salesCountFail
        }
        
        guard let price = dataDictionary["price"] as? Int else {
            throw ProductInitError.priceFail
        }
        
        guard let storeName = dataDictionary["store_name"] as? String else {
            throw ProductInitError.storeNameFail
        }
        
        guard let content = dataDictionary["content"] as? String else {
            throw ProductInitError.contentFail
        }
        
        guard let link = dataDictionary["link"] as? String else {
            throw ProductInitError.linkFail
        }
        
        guard let imageURLString = dataDictionary["image"] as? String else {
            throw ProductInitError.imageURLStringFail
        }
        
        guard let imageSmallURLString = dataDictionary["image_small"] as? String else {
            throw ProductInitError.imageSmallURLStringFail
        }
        
        guard let imageOriginURLString = dataDictionary["image_original"] as? String else {
            throw ProductInitError.imageOriginURLStringFail
        }
        
        guard let addresses = dataDictionary["addresses"] as? [[String:Any]] else {
            throw ProductInitError.addressesFail
        }
        
        self.id = id
        self.companyName = companyName
        self.title = title
        self.salesCount = salesCount
        self.price = price
        self.storeName = storeName
        self.content = content
        self.link = link
        self.imageURLString = imageURLString
        self.imageSmallURLString = imageSmallURLString
        self.imageOriginURLString = imageOriginURLString
        self.addresses = addresses
        
    }
}
