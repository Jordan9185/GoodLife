//
//  WebViewController.swift
//  GoodLife
//
//  Created by JordanLin on 2017/9/27.
//  Copyright © 2017年 JordanLin. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpWebView()
        
    }
    
    func setUpWebView() {
        
        webView = WKWebView(frame: self.view.frame)
        
        let url = URL(string: "http://igoodtravel.com/oauth/authorize?client_id=\(clientID)&redirect_uri=\(redirectURI)&response_type=code")
        
        let request = URLRequest(url: url!)
        
        webView.load(request)
        
        webView.navigationDelegate = self
        
        self.view.addSubview(webView)
        
    }
    
    func requestAccessToken(with requestCode: String) {
        
        let requestTokenUrlString = "http://api.igoodtravel.com/oauth/token?grant_type=authorization_code&code=\(requestCode)&client_id=\(clientID)&client_secret=\(clientSecret)&redirect_uri=\(redirectURI)"
        
        let url = URL(string: requestTokenUrlString)
        
        var request = URLRequest(url: url!)
        
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                return
            }
            
            if let json = try? JSONSerialization.jsonObject(with: data!, options: []) {
                
                if let jsonData = json as? [String:Any] {
                    
                    let accessToken = jsonData["access_token"]
                    
                    UserDefaults.standard.set(accessToken, forKey: "accessToken")
                    
                    UserDefaults.standard.synchronize()
                    
                }
                
            }
            
        }.resume()
        
    }
    
    //MARK: WKNavigationDelegate
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if let scheme = webView.url?.scheme {
            
            switch scheme {
                
            case "goodlifebuy":
                
                let urlComponent = URLComponents(url: webView.url!, resolvingAgainstBaseURL: true)
                
                let requestCode = (urlComponent?.queryItems?.first?.value)!
                
                requestAccessToken(with: requestCode)
                
                decisionHandler(WKNavigationActionPolicy.cancel)
                
            default:
                
                decisionHandler(WKNavigationActionPolicy.allow)
                
            }
            
        }
        
    }

}
