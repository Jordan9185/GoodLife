//
//  AppDelegate.swift
//  GoodLife
//
//  Created by JordanLin on 2017/9/27.
//  Copyright © 2017年 JordanLin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       
        if let accessToken = UserDefaults.standard.object(forKey: "accessToken") {
            
            let productStoryBoard = UIStoryboard(name: "Product", bundle: nil)
            
            let productTabBarController = productStoryBoard.instantiateViewController(withIdentifier: "productTabBarController"
            )
            self.window?.rootViewController = productTabBarController
            
        } else {
            
            let landingStoryBoard = UIStoryboard(name: "Landing", bundle: nil)
            
            let landingViewController = landingStoryBoard.instantiateViewController(withIdentifier: "LandingNavigationController")
            
            self.window?.rootViewController = landingViewController
        }
        
        return true
    }
    
    class var shared: AppDelegate {
        
        return UIApplication.shared.delegate as! AppDelegate
        
    }

}

