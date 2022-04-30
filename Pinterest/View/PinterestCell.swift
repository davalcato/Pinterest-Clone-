//
//  PinterestCell.swift
//  Pinterest
//
//  Created by Daval Cato on 12/18/21.
//

import UIKit

class PinterestCell: UICollectionViewCell {
    
    // declare here
    let mainImgView: UIImageView = {
        let iv = UIImageView()
        // setup properties
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()
    
    // more button
    lazy var moreImgView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "more")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.lightGray
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moreImgViewAction)))
        
        
//        moreImgView.addTarget(self, action: #selector(moreImgViewAction), for: .touchUpInside)
        
        
        return iv
        
    }()
    
    @objc func moreImgViewAction(_ sender: Any) {

        print("Button tapped")
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // add constraints
        backgroundColor = .clear
        
        addSubview(mainImgView)
        addSubview(moreImgView)
        
        mainImgView.constraint(
            top: topAnchor,
            left: leftAnchor,
            bottom: moreImgView.topAnchor,
            right: rightAnchor,
            topConstant: 0,
            leftConstant: 0,
            bottomConstant: 0,
            rightConstant: 0,
            widthConstant: 0,
            heightConstant: 0)
        
        moreImgView.constraint(
            top: nil,
            left: nil,
            bottom: bottomAnchor,
            right: rightAnchor,
            topConstant: 10,
            leftConstant: 0,
            bottomConstant: 0,
            rightConstant: 0,
            widthConstant: 15,
            heightConstant: 15)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}






