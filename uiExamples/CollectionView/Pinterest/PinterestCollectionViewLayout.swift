//
//  PinterestCollectionViewLayout.swift
//  uiExamples
//
//  Created by David Martinez on 14/03/2017.
//  Copyright © 2017 Atenea. All rights reserved.
//

import UIKit

protocol PinterestCollectionViewLayoutDelegate: NSObjectProtocol {
    
    func collectionView(collectionView: UICollectionView,
                        heightForPhotoAtIndexPath indexPath: IndexPath,
                        cellWidth: CGFloat) -> CGFloat
    
    func collectionView(collectionView: UICollectionView,
                        heightForAnnotationAtIndexPath indexPath: IndexPath,
                        cellWidth width: CGFloat) -> CGFloat
}

class PinterestCollectionViewLayout: UICollectionViewLayout {

    private weak var delegate: PinterestCollectionViewLayoutDelegate?
    
    private var numberOfColumns = 2
    private var cellPadding: CGFloat = 8.0
    
    private var cache = [PinterestLayoutAttributes]()
    
    private var contentHeight: CGFloat  = 0.0
    private var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return collectionView!.bounds.width - (insets.left + insets.right)
    }

    func setDelegate(delegate: PinterestCollectionViewLayoutDelegate?) {
        self.delegate = delegate
    }
    
    /**
     - Description:
        This method is called whenever a layout operation is about to
        take place. It’s your opportunity to prepare and perform any
        calculations required to determine the collection view size and
        the positions of the items.
    */
    override func prepare() {
        
        if cache.isEmpty {
            calculateCollectionViewLayoutAttributes()
        }
    }
    
    private func calculateCollectionViewLayoutAttributes() {
        
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset = [CGFloat]()
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        
        var column = 0
        var yOffset = [CGFloat](repeating:0, count: numberOfColumns)
        
        let section = 0
        let numberOfItemsInSection = collectionView!.numberOfItems(inSection: section)
        let cellWidth = columnWidth - cellPadding * 2
        
        for item in 0 ..< numberOfItemsInSection {
            
            let indexPath = IndexPath(item: item, section: section)
            
            let photoHeight = delegate?.collectionView(collectionView: collectionView!,
                                                       heightForPhotoAtIndexPath: indexPath,
                                                       cellWidth: cellWidth) ?? 0
            
            let annotationHeight = delegate?.collectionView(collectionView: collectionView!,
                                                            heightForAnnotationAtIndexPath: indexPath,
                                                            cellWidth: cellWidth) ?? 0
            
            let height = cellPadding + photoHeight + annotationHeight + cellPadding
            
            let currentXOffset = xOffset[column]
            let currentYOffset = yOffset[column]
            let frame = CGRect(x: currentXOffset, y: currentYOffset, width: columnWidth, height: height)
            
            let insetFrame = getInsetFrame(frame: frame, column: column)
            
            let attributtes = PinterestLayoutAttributes(forCellWith: indexPath)
            attributtes.frame = insetFrame
            attributtes.photoHeight = photoHeight
            cache.append(attributtes)
            
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            
            column = getNextColumn(yOffset: yOffset, currentColumn: column)
        }
    }
    
    /**
     Calculate the next column where the next cell must be added. The column
     selected is that with the minimum offset into columns yOffset array
    */
    private func getNextColumn(yOffset: [CGFloat], currentColumn: Int) -> Int {
        let defaultColumn = (currentColumn + 1) % numberOfColumns
        guard let minOffset = yOffset.min() else {
            return defaultColumn
        }
        return yOffset.index(of: minOffset) ?? defaultColumn
    }
    
    /**
     Return the inset frame for the frame given that will be located in column.
     If column is first
        inset -> {top:x left:x bottom:0 right:x/2}
     If column is last 
        inset -> {top:x left:x bottom: right:}
     else
        inset -> {top: left: bottom: right:}
    */
    private func getInsetFrame(frame: CGRect, column:Int) -> CGRect {
        return frame.insetBy(dx: cellPadding, dy: cellPadding)
    }
    
    /**
        In this method, you have to return the height and width of the entire
        collection view content — not just the visible content. The collection
        view uses this information internally to configure its scroll view
        content size.

    */
    override var collectionViewContentSize: CGSize {
        
        get {
            return CGSize(width: contentWidth, height: contentHeight)
        }
    }
    
    /**
        In this method you need to return the layout attributes for 
        all the items inside the given rectangle. You return the attributes 
        to the collection view as an array of UICollectionViewLayoutAttributes.
    */
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            if rect.intersects(attributes.frame) {
                layoutAttributes.append(attributes)
            }
        }
        
        return layoutAttributes
    }
    
    /**
     This overrides layoutAttributesClass() to tell the collection view 
     to use PinterestLayoutAttributes whenever it creates 
     layout attributes objects.
    */
    override class var layoutAttributesClass: AnyClass {
        get {
            return PinterestLayoutAttributes.self
        }
    }
}

/**
 By subclassing UICollectionViewLayoutAttributes, you can add your own 
 properties, which are automatically passed to the cell. You can use 
 these attributes by overriding applyLayoutAttributes(_:) in your 
 UICollectionViewCell subclass, which your collection view calls 
 during the layout process
 */
class PinterestLayoutAttributes: UICollectionViewLayoutAttributes {
    
    var photoHeight: CGFloat = 0.0
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! PinterestLayoutAttributes
        copy.photoHeight = photoHeight
        return copy
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let attributes = object as? PinterestLayoutAttributes else {
            return false
        }
        
        if attributes.photoHeight == photoHeight {
            return super.isEqual(object)
        }
        
        return false
    }
}
