//
//  FeedViewController.swift
//  Pinterest
//
//  Created by Daval Cato on 11/13/21.
//

import UIKit


class FeedViewController: UIViewController {
    // adding search
    let searchTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Search"
        tf.backgroundColor = UIColor.white
        tf.clipsToBounds = true
        tf.layer.cornerRadius = 10
        
        return tf
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        
        // add navBar
        guard let navBar = navigationController?.navigationBar else { return }
        
        navBar.isTranslucent = false
        navBar.backgroundColor = .white
        
        // add search as subview
        navBar.addSubview(searchTF)
        
        searchTF.constraint(
            top: navBar.topAnchor,
            left: navBar.leftAnchor,
            bottom: navBar.bottomAnchor,
            right: navBar.rightAnchor,
            topConstant: 5,
            leftConstant: 10,
            bottomConstant: 5,
            rightConstant: 10,
            widthConstant: 0,
            heightConstant: 0)
        
        
    }
}

