//
//  FeedViewController.swift
//  Pinterest
//
//  Created by Daval Cato on 11/13/21.
//

import UIKit


class FeedViewController: UIViewController {
    
    // setup collectionView
    let collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.register(PinterestCell.self, forCellWithReuseIdentifier: "cellId")
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.contentInset.top = 5
        
        return cv
    }()
    
    // adding search
    let searchTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Search"
        tf.backgroundColor = #colorLiteral(red: 0.9588784575, green: 0.9528519511, blue: 0.9350754619, alpha: 1)
        tf.clipsToBounds = true
        tf.layer.cornerRadius = 10
        
        // containview for search field
        let rightView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: 38,
            height: -10))
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
            leftConstant: -0,
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
    
    // call a method here
    let posts = PostProvider.GetPosts()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // set the collectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupNavBar()
        
        // add the collectionView as a subview
        view.addSubview(collectionView)
        
        collectionView.constraint(
            top: view.topAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            topConstant: 0,
            leftConstant: 0,
            bottomConstant: 0,
            rightConstant: 0,
            widthConstant: 0,
            heightConstant: 0)
        
    // navBar into separate function
    func setupNavBar() {
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
            rightConstant: 10,
            widthConstant: 0,
            heightConstant: 0)
        
        }
    }
}

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as?
            PinterestCell {
            cell.mainImgView.image = posts[indexPath.row].image
            return cell
        }
        // otherwise return UICollectionViewCell
        return UICollectionViewCell()
    }
}

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
    let moreImgView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "more")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.lightGray
        
        return iv
        
    }()
    
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
