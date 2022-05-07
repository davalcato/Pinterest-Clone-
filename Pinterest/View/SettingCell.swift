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
    
    override func setupViews() {
        super.setupViews()
        // add name label here
        addSubview(nameLabel)
        
        // call custom function
        addConstraintsWithFormat(format: "H:|[v0]|", views: nameLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        
    }
}








