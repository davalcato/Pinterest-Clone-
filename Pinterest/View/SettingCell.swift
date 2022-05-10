//
//  SettingCell.swift
//  Pinterest
//
//  Created by Daval Cato on 5/5/22.
//

import UIKit

class SettingCell: BaseCell {
    
    // adding name label to the cell
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        return label
        
    }()
    
    // add item view to the cells
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        // set the image
        imageView.image = UIImage(named: "settings")
        imageView.contentMode = .scaleAspectFill
        return imageView
        
    }()
    
    override func setupViews() {
        super.setupViews()
        // add name label here
        addSubview(nameLabel)
        // add icon image into cell
        addSubview(iconImageView)
        
        // call custom function
        addConstraintsWithFormat(format: "H:|-8-[v0(30)]-8-[v1]|", views: iconImageView, nameLabel)
        
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        
        // establish the height of imageview cell
        addConstraintsWithFormat(format: "V:[v0(30)]", views: iconImageView)
        
        // fixing the settings image icon
        addConstraint(NSLayoutConstraint(
            item: iconImageView,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerY,
            multiplier: 1,
            constant: 0))
        
    }
}








