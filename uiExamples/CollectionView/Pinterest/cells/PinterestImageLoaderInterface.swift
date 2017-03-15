//
//  PinterestImageLoaderInterface.swift
//  uiExamples
//
//  Created by David Martinez on 15/03/2017.
//  Copyright © 2017 Atenea. All rights reserved.
//

import UIKit
import SDWebImage

protocol PinterestImageLoaderInterface: NSObjectProtocol {
    
    func cancelImageLoad(imageView: UIImageView)
    func loadImage(url: URL, into imageView: UIImageView)
    
}

class PinterestImageLoader: NSObject, PinterestImageLoaderInterface {
    
    func loadImage(url: URL, into imageView: UIImageView) {
        imageView.sd_setImage(with: url)
    }
    
    func cancelImageLoad(imageView: UIImageView) {
        imageView.sd_cancelCurrentImageLoad()
    }
}
