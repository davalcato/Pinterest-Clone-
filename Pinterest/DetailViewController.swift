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
    
    let backBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "back"), for: .normal)
        btn.contentEdgeInsets = UIEdgeInsets(
            top: 8,
            left: 8,
            bottom: 8,
            right: 8)
        btn.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
        
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // constrain back button
        view.addSubview(backBtn)
        
        backBtn.constraint(
            top: view.topAnchor,
            left: view.leftAnchor,
            bottom: nil,
            right: nil,
            topConstant: 40,
            leftConstant: 18,
            bottomConstant: 0,
            rightConstant: 0,
            widthConstant: 38,
            heightConstant: 38)
        
    }
    // add the selector method
    @objc func backBtnTapped() {
        dismiss(animated: true, completion: nil)
        
    }
    
}







