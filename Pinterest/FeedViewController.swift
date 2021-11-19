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
        tf.backgroundColor = #colorLiteral(red: 0.9588784575, green: 0.9528519511, blue: 0.9350754619, alpha: 1)
        tf.clipsToBounds = true
        tf.layer.cornerRadius = 10
        
        // containview for search
        let rightView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: 38,
            height: 25))
        // button
        let rightBtn = UIButton(type: .custom)
        rightBtn.setImage(UIImage(named: "camera-icon"), for: .normal)
        // set frame
        rightBtn.frame = CGRect(
            x: 0,
            y: 0,
            width: 25,
            height: 25)
        
        rightView.addSubview(rightBtn)
        
        // anchor right button
        rightBtn.constraint(
            top: nil,
            left: nil,
            bottom: nil,
            right: rightView.rightAnchor,
            topConstant: 0,
            leftConstant: 0,
            bottomConstant: 5,
            rightConstant: 18,
            widthConstant: 25,
            heightConstant: 25)
        rightView.centerYAnchor.constraint(equalTo: rightView.centerYAnchor).isActive = true
        // set the rightView property on the text
        tf.rightView = rightView
        tf.rightViewMode = .always
        // containview
        let leftView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: 38,
            height: 25))
        // button
        let leftBtn = UIButton(type: .custom)
        leftBtn.setImage(UIImage(named: "search-icon"), for: .normal)
        // set frame
        leftBtn.frame = CGRect(
            x: 0,
            y: 0,
            width: 25,
            height: 25)
        
        leftView.addSubview(leftBtn)
        
        // anchor right button
        leftBtn.constraint(
            top: nil,
            left: leftView.leftAnchor,
            bottom: nil,
            right: nil,
            topConstant: 0,
            leftConstant: 13,
            bottomConstant: 0,
            rightConstant: 0,
            widthConstant: 17,
            heightConstant: 17)
        
        leftBtn.centerYAnchor.constraint(equalTo: leftView.centerYAnchor).isActive = true
        // set the rightView property on the text
        tf.leftView = leftView
        tf.leftViewMode = .always
        
        return tf
        
    }()
    // add chat button
    let chatBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "chatbubble"), for: .normal)
        
        return btn
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
        navBar.addSubview(chatBtn)
        
        chatBtn.constraint(
            top: nil,
            left: nil,
            bottom: nil,
            right: navBar.rightAnchor,
            topConstant: 0,
            leftConstant: 0,
            bottomConstant: 0,
            rightConstant: 18,
            widthConstant: 25,
            heightConstant: 25)
        chatBtn.centerYAnchor.constraint(equalTo: navBar.centerYAnchor).isActive = true
        
        searchTF.constraint(
            top: navBar.topAnchor,
            left: navBar.leftAnchor,
            bottom: navBar.bottomAnchor,
            right: chatBtn.leftAnchor,
            topConstant: 5,
            leftConstant: 10,
            bottomConstant: 5,
            rightConstant: 18,
            widthConstant: 0,
            heightConstant: 0)
        
    }
}

