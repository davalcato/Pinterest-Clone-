//
//  FeedViewController.swift
//  Pinterest
//
//  Created by Daval Cato on 11/13/21.
//

import UIKit


class FeedViewController: UIViewController {
    
    // setup collectionView - lazy var to access self delegate
    lazy var collectionView: UICollectionView = {
        let layout = PinterestLayout()
        layout.delegate = self
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
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
    // add new method
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        // create new variable
        let vc = DetailViewController()
        
        if let pinterestCell = collectionView.cellForItem(at: indexPath) as? PinterestCell {
            vc.cc_setZoomTransition(originalView: pinterestCell.mainImgView)
            
            let i : UIImage = posts[indexPath.row].image
            // define the image from detailView
            let resizedImage = i.resizeImage(newSize: CGSize(width: UIScreen.main.bounds.width - 36, height: (UIScreen.main.bounds.width - 36) * (i.size.height / i.size.width)))
            
            // set post for viewcontroller
            vc.post = Post(image: resizedImage,
                           title: posts[indexPath.row].title,
                           description: posts[indexPath.row].description)
            
        }
        
        self.present(vc, animated: true, completion: nil)
        
        return false
    }
}

// conform to layoutDelegate
extension FeedViewController: PinterestLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath) -> CGFloat {
        return posts[indexPath.row].image.size.height / 4
    }
}


