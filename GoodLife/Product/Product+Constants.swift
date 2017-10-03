//
//  Product+Constants.swift
//  GoodLife
//
//  Created by JordanLin on 2017/9/28.
//  Copyright © 2017年 JordanLin. All rights reserved.
//

import Foundation

var productListURLString: String {
    
    if let url = Bundle.main.url(forResource:"GoodLife", withExtension: "plist") {
        do {
            let data = try Data(contentsOf:url)
            let swiftDictionary = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [String:Any]
            
            return swiftDictionary["ProductListURLString"] as! String
            
        } catch {
            print(error)
        }
    }
    
    return ""
}

var favoriteListURLString: String {
    
    if let url = Bundle.main.url(forResource:"GoodLife", withExtension: "plist") {
        do {
            let data = try Data(contentsOf:url)
            let swiftDictionary = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [String:Any]
            
            return swiftDictionary["FavoriteListURLString"] as! String
            
        } catch {
            print(error)
        }
    }
    
    return ""
}

var webAPIKey: String {
    
    if let url = Bundle.main.url(forResource:"GoodLife", withExtension: "plist") {
        do {
            let data = try Data(contentsOf:url)
            let swiftDictionary = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [String:Any]
            
            return swiftDictionary["WebAPIKey"] as! String
            
        } catch {
            print(error)
        }
    }
    
    return ""
}
