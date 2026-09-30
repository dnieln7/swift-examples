//
//  DetailViewController.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 26/12/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel()
        label.frame = CGRect(x: 20, y: 16, width: 250, height: 30)
        label.font = UIFont.systemFont(ofSize: 30)
        label.text = "Detail View"
        
        view.addSubview(label)
    }
}
