//
//  PinterestCollectionViewCell.swift
//  uiExamples
//
//  Created by David Martinez on 14/03/2017.
//  Copyright © 2017 Atenea. All rights reserved.
//

import UIKit

class PinterestCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    
    private var imageLoader: PinterestImageLoaderInterface!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageLoader = PinterestFactory.getImageLoader()
    }
    
    override func prepareForReuse() {
        imageLoader.cancelImageLoad(imageView: imageView)
        imageView.image = nil
        captionLabel.text = nil
        titleLabel.text = nil
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let attributes = layoutAttributes as? PinterestLayoutAttributes {
            imageViewHeightConstraint.constant = attributes.photoHeight
        }
    }
    
    func showPinterestItem(pinterestItem: PinterestItem) {
        
        let stringUrl = pinterestItem.imageUrl
        if stringUrl != nil, let url = URL(string: stringUrl!){
            imageLoader.loadImage(url: url, into: imageView)
        }
        
        captionLabel.text = pinterestItem.caption
        titleLabel.text = pinterestItem.title
    }
    
}
