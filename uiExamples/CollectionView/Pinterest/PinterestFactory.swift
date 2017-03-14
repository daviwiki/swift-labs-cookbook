//
//  PinterestFactory.swift
//  uiExamples
//
//  Created by David Martinez on 14/03/2017.
//  Copyright © 2017 Atenea. All rights reserved.
//

import UIKit

class PinterestFactory: NSObject {

    static func getPresenter() -> PinterestPresenter {
        return PinterestPresenter()
    }
    
}
