//
//  WebView.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 20/02/25.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let wkWebView = WKWebView()

    @Binding var currentUrl: String
    @Binding var canGoBack: Bool

    func makeUIView(context: Context) -> some UIView {
        let urlRequest = URLRequest(url: URL(string: "https://www.google.com")!)

        wkWebView.navigationDelegate = context.coordinator
        wkWebView.load(urlRequest)

        return wkWebView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        // Not used
    }

    func makeCoordinator() -> WebViewCoordinator {
        return WebViewCoordinator(currentUrl: $currentUrl, canGoBack: $canGoBack)
    }

    func loadPage(pageURL: URL) {
        wkWebView.load(URLRequest(url: pageURL))
    }

    func back() {
        wkWebView.goBack()
    }
}

class WebViewCoordinator: NSObject, WKNavigationDelegate {
    @Binding var currentUrl: String
    @Binding var canGoBack: Bool

    init(currentUrl: Binding<String>, canGoBack: Binding<Bool>) {
        _currentUrl = currentUrl
        _canGoBack = canGoBack
    }

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        debugPrint("webView: \(webView), didCommit: \(navigation)")

        if let url = webView.url {
            currentUrl = url.absoluteString
        }
        
        canGoBack = webView.canGoBack
    }
}
