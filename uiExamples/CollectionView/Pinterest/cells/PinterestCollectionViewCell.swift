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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        imageView.image = nil
        captionLabel.text = nil
        titleLabel.text = nil
    }
    
    func showPinterestItem(pinterestItem: PinterestItem) {
        // TODO: Load image
        captionLabel.text = pinterestItem.caption
        titleLabel.text = pinterestItem.title
    }
    
}
