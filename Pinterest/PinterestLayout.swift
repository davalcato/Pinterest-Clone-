//
//  PinterestLayout.swift
//  Pinterest
//
//  Created by Daval Cato on 12/7/21.
//


import UIKit

// define the class
class PinterestLayout: UICollectionViewLayout {
    // define the properties
    var numberOfColumns = 2
    var cellPadding = 5
    // array of
    var cashedAttributes = [UICollectionViewLayoutAttributes]()
    
    var contentHeight: CGFloat = 0
    
    // override the collectionViewContentSize
    override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView else { return CGSize.zero }
        // move the insets
        let insets = collectionView.contentInset
        
        return CGSize(width: collectionView.bounds.width - (insets.left + insets.right), height: contentHeight)
    }
    
    override func prepare() {
        // check if empty -- then make sure a collectionView is passed in
        guard cashedAttributes.isEmpty == true, let collectionView = collectionView else { return }
        
        let columnWidth = collectionViewContentSize.width / CGFloat(numberOfColumns)
        var xPosition = [CGFloat]()
        for column in 0 ..< numberOfColumns {
            xPosition.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yPosition = [CGFloat](repeating: 0, count: numberOfColumns)
        
        // loop thru all this items in the collection
        for item in 0..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
        }
    }
}




