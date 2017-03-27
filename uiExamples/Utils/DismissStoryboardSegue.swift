//
//  DismissStoryboardSegue.swift
//  uiExamples
//
//  Created by David Martinez on 25/03/2017.
//  Copyright © 2017 Atenea. All rights reserved.
//

import UIKit

class DismissStoryboardSegue: UIStoryboardSegue {

    override func perform() {
        source.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
