//
//  WebKitFrameworkViewModel.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 20/02/25.
//

import Foundation

class WebKitFrameworkViewModel: ObservableObject {
    @Published var currentUrl = ""
    @Published var canGoBack = false
}
