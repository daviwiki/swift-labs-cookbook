//
//  PinterestProjectDefinition.swift
//  uiExamples
//
//  Created by David Martinez on 13/03/2017.
//  Copyright © 2017 Atenea. All rights reserved.
//

import UIKit

class PinterestProjectDefinition: NSObject, ProjectDispatcherInterface {

    static func getProject() throws -> Project {
        let builder = Project.Builder()
        builder.setName(name: "Pinterest")
        builder.setNavigation(navigation: { (navigation: UINavigationController) in
            let controller = PinterestViewController(nibName: "PinterestViewController", bundle: nil)
            navigation.present(controller, animated: true, completion: nil)
//            navigation.pushViewController(controller, animated: true)
        })
        
        return try builder.build()
    }
    
}
