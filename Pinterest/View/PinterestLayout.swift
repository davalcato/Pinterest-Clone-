//
//  PinterestLayout.swift
//  Pinterest
//
//  Created by Daval Cato on 12/7/21.
//


import UIKit

protocol PinterestLayoutDelegate: class {
    // delegate method for the feedview
    func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath)
    -> CGFloat
    
}

// define the class
class PinterestLayout: UICollectionViewLayout {
    
    weak var delegate: PinterestLayoutDelegate!
    // define the properties
    var numberOfColumns = 2
    var cellPadding: CGFloat = 5
    // array of
    var cachedAttributes = [UICollectionViewLayoutAttributes]()
    
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
        guard cachedAttributes.isEmpty == true, let collectionView = collectionView else { return }
        
        let columnWidth = collectionViewContentSize.width / CGFloat(numberOfColumns)
        var xPosition = [CGFloat]()
        for column in 0 ..< numberOfColumns {
            xPosition.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yPosition = [CGFloat](repeating: 0, count: numberOfColumns)
        
        // loop thru all this items in the collection
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            // calculate the frame of cell
            let photoHeight = delegate.collectionView(collectionView, heightForImageAtIndexPath: indexPath)
            // calculate the height
            let height = cellPadding * 2 + photoHeight
            // frame
            let frame = CGRect(
                x: xPosition[column],
                y: yPosition[column],
                width: columnWidth,
                height: height)
            
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            // append
            cachedAttributes.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            
            // advance the y position offset
            yPosition[column] = yPosition[column] + height
            
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }
    // method
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // calculate the visiblelayout
        var visiblelayoutAttributes = [UICollectionViewLayoutAttributes]()
        // loop thru the cached attributes
        for attributes in cachedAttributes {
            // if frame is correct append it to the array
            if attributes.frame.intersects(rect) {
                visiblelayoutAttributes.append(attributes)
            }
        }
        
        return visiblelayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cachedAttributes[indexPath.item]
    }
    
}




