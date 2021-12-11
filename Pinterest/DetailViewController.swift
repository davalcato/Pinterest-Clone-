//
//  DetailViewController.swift
//  Pinterest
//
//  Created by Daval Cato on 12/11/21.
//

import UIKit

// define the class
class DetailViewController: UIViewController {
    
    var post: Post? {
        didSet {
            guard let p = post else { return }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
}







