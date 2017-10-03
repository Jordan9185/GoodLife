//
//  Landing+Constants.swift
//  GoodLife
//
//  Created by JordanLin on 2017/9/27.
//  Copyright © 2017年 JordanLin. All rights reserved.
//

import Foundation

var clientID: String {
    
    if let url = Bundle.main.url(forResource:"GoodLife", withExtension: "plist") {
        do {
            let data = try Data(contentsOf:url)
            let swiftDictionary = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [String:Any]
            
            return swiftDictionary["ClientID"] as! String
            
        } catch {
            print(error)
        }
    }
    
    return ""
}

var clientSecret: String {
    
    if let url = Bundle.main.url(forResource:"GoodLife", withExtension: "plist") {
        do {
            let data = try Data(contentsOf:url)
            let swiftDictionary = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [String:Any]
            
            return swiftDictionary["ClientSecret"] as! String
            
        } catch {
            print(error)
        }
    }
    
    return ""
}

var requestCode: String {
    
    if let url = Bundle.main.url(forResource:"GoodLife", withExtension: "plist") {
        do {
            let data = try Data(contentsOf:url)
            let swiftDictionary = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [String:Any]
            
            return swiftDictionary["RequestCode"] as! String
            
        } catch {
            print(error)
        }
    }
    
    return ""
}

var redirectURI: String {
    
    if let url = Bundle.main.url(forResource:"GoodLife", withExtension: "plist") {
        do {
            let data = try Data(contentsOf:url)
            let swiftDictionary = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [String:Any]
            
            return swiftDictionary["RedirectURI"] as! String
            
        } catch {
            print(error)
        }
    }
    
    return ""
}
