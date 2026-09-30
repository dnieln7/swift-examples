//
//  WebKitFrameworkView.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 20/02/25.
//

import SwiftUI

struct WebKitFrameworkView: View {
    @ObservedObject var viewModel = WebKitFrameworkViewModel()
//    @State var currentUrl = ""
    
    var webView: WebView!
    
    init() {
        webView = WebView(currentUrl: $viewModel.currentUrl, canGoBack: $viewModel.canGoBack)
    }
    
    var body: some View {
        VStack {
            TextField("url", text: $viewModel.currentUrl)
                .padding()
            HStack {
                Button("Go") {
                    webView.loadPage(pageURL: URL(string: viewModel.currentUrl)!)
                }
                Button("Back") {
                    webView.back()
                }
                .disabled(!viewModel.canGoBack)
            }
            webView
        }
    }
}

#Preview {
    WebKitFrameworkView()
}
