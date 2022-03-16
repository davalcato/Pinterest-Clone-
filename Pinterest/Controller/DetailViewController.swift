//
//  DetailViewController.swift
//  Pinterest
//
//  Created by Daval Cato on 12/11/21.
//

import UIKit

extension UIImage {
    
    func resizeImage(newSize: CGSize) -> UIImage {
        // create a graphic context
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        // define the image
        self.draw(in: CGRect(
            x: 0,
            y: 0,
            width: newSize.width,
            height: newSize.height))
        
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        // end the graphics
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

// define the class
class DetailViewController: UIViewController {
    
    var post: Post? {
        didSet {
            guard let p = post else { return }
            
            imageView.image = p.image
            titleLbl.text = p.title
            descriptionLbl.text = p.description
            
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
    
    // add image view
    let imageView: UIImageView = {
        let iv = UIImageView()
        // setup properties
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        
        return iv
    }()
    
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 2
        lbl.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        lbl.textColor = UIColor.mainGray
        
        return lbl
    }()
    
    let descriptionLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        lbl.textColor = UIColor.mainGray
        
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupElements()
    }
    // add the selector method
    @objc func backBtnTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    func setupElements() {
        // constrain back button
        view.addSubview(backBtn)
        view.addSubview(imageView)
        view.addSubview(titleLbl)
        view.addSubview(descriptionLbl)
        
        
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
        
        imageView.constraint(
            top: backBtn.bottomAnchor,
            left: view.leftAnchor,
            bottom: nil,
            right: view.rightAnchor,
            topConstant: 20,
            leftConstant: 18,
            bottomConstant: 0,
            rightConstant: 18,
            widthConstant: 0,
            heightConstant: 0)
        
        titleLbl.constraint(
            top: imageView.bottomAnchor,
            left: view.leftAnchor,
            bottom: nil,
            right: view.rightAnchor,
            topConstant: 18,
            leftConstant: 18,
            bottomConstant: 0,
            rightConstant: 18,
            widthConstant: 0,
            heightConstant: 0)
        
        descriptionLbl.constraint(
            top: titleLbl.bottomAnchor,
            left: view.leftAnchor,
            bottom: nil,
            right: view.rightAnchor,
            topConstant: 20,
            leftConstant: 18,
            bottomConstant: 0,
            rightConstant: 18,
            widthConstant: 0,
            heightConstant: 0)
        
    }
    
    
}







