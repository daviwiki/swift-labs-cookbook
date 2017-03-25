//
//  PinteresetItem.swift
//  uiExamples
//
//  Created by David Martinez on 14/03/2017.
//  Copyright © 2017 Atenea. All rights reserved.
//

import UIKit

class PinterestItem: NSObject {

    private(set) var imageUrl: String?
    private(set) var caption: String = ""
    private(set) var title: String = ""
    
    class Builder: NSObject {
        
        let pinterest = PinterestItem()
        
        func setImageUrl(url: String?) {
            pinterest.imageUrl = url
        }
        
        func setCaption(caption: String) {
            pinterest.caption = caption
        }
        
        func setTitle(title: String) {
            pinterest.title = title
        }
        
        func build() -> PinterestItem {
            return pinterest
        }
    }
    
}
