//
//  UIKitViewController.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 26/12/24.
//

import SwiftUI

struct UIKitViewController:UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return DetailViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

struct UIKitControllerContainerView: View {
    var body: some View {
        VStack {
            UIKitViewController()
        }
    }
}

#Preview {
    UIKitControllerContainerView()
}
