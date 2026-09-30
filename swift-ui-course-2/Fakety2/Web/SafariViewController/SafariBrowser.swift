//
//  SafariBrowser.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 20/02/25.
//

import SafariServices
import SwiftUI

struct SafariBrowser: UIViewControllerRepresentable {
    @Binding var searchURL: URL
    @Binding var hasOpened: Bool

    func makeUIViewController(context: Context) -> some UIViewController {
        let safariConfiguration = SFSafariViewController.Configuration()
        safariConfiguration.barCollapsingEnabled = false

        let safari = SFSafariViewController(url: searchURL)
        safari.dismissButtonStyle = .close
        safari.preferredBarTintColor = .yellow
        safari.preferredControlTintColor = .black
        safari.delegate = context.coordinator

        return safari
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Not used
    }

    func makeCoordinator() -> SafariCoordinator {
        return SafariCoordinator(hasOpened: $hasOpened)
    }
}

class SafariCoordinator: NSObject, SFSafariViewControllerDelegate {
    @Binding var hasOpened: Bool

    init(hasOpened: Binding<Bool>) {
        _hasOpened = hasOpened
    }

    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        hasOpened = true
    }
    
    func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
        debugPrint("didCompleteInitialLoad: \(didLoadSuccessfully)")
    }
    
    func safariViewController(_ controller: SFSafariViewController, initialLoadDidRedirectTo URL: URL) {
        debugPrint("initialLoadDidRedirectTo: \(URL)")
    }
    
    func safariViewControllerWillOpenInBrowser(_ controller: SFSafariViewController) {
        debugPrint("willOpenInBrowser")
    }
}
