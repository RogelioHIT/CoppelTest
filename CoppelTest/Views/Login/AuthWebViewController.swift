//
//  WebViewController.swift
//  CoppelTest
//
//  Created by Rogelio on 07/07/22.
//

import UIKit
import WebKit

protocol AuthWebViewDelegate {
    func authDismissWith(token: String, allowed: Bool)
}

class AuthWebViewController: UIViewController {
    
    var webView: WKWebView!
    var webViewAuthDelegate: AuthWebViewDelegate!
    var token: String!
    
    override func loadView() {
        super.loadView()
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupURL()
    }
    
    func setupURL() {
        let myURL = URL(string: "\(Endpoint.authenticate.urlString + token)")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}

extension AuthWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard let url = webView.url else {
            return
        }

        if url.lastPathComponent == "deny" || url.lastPathComponent == "allow" {
            let allowed = url.lastPathComponent == "allow"
            webViewAuthDelegate.authDismissWith(token: self.token, allowed: allowed)
        }
        
    }
}
