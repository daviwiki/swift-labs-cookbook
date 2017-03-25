//
//  PinterestPresenter.swift
//  uiExamples
//
//  Created by David Martinez on 14/03/2017.
//  Copyright © 2017 Atenea. All rights reserved.
//

import UIKit

class PinterestPresenter: NSObject {

    private weak var view: PinterestView?
    
    func bind(view: PinterestView) {
        self.view = view
    }
    
    func loadMoreItems() {
        let items = generateFakeItems()
        view?.appendPinteresetItems(items: items)
    }
    
    private func generateFakeItems() -> [PinterestItem] {
        var items: [PinterestItem] = []
        
        for _ in 1...20 {
            let item = PinterestItemRandomizer.getRandomItem()
            items.append(item)
        }
        
        return items
    }
    
    
}

class PinterestItemRandomizer: NSObject {
    
    private static let titles = [
        "Minions ipsum chasy belloo!",
        "Minions ipsum chasy belloo! Me want bananaaa! Baboiii tank yuuu",
        "Minions ipsum chasy belloo! Me want bananaaa! Baboiii tank yuuu! Hahaha belloo! Bananaaaa baboiii hana dul sae jiji uuuhhh. Tulaliloo potatoooo poulet tikka masala butt tulaliloo potatoooo aaaaaah butt baboiii para tú"
    ]
    
    private static let captions = [
        "caption",
        "medium caption",
        "laaaaaaaarge caption"
    ]
    
    private static let images = [
        "https://unsplash.it/320/180",
        "https://unsplash.it/320/320",
        "https://unsplash.it/180/320",
        "https://unsplash.it/100/320",
        "https://unsplash.it/64/64"
    ]
    
    static func getRandomItem() -> PinterestItem {
        let title = titles[Int(arc4random_uniform(2))]
        let caption = captions[Int(arc4random_uniform(2))]
        let image = images[Int(arc4random_uniform(4))]
        
        let builder = PinterestItem.Builder()
        builder.setTitle(title: title)
        builder.setCaption(caption: caption)
        builder.setImageUrl(url: image)
        return builder.build()
    }
}
