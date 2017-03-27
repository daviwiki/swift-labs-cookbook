//
//  WWDC2016AnimationsProject.swift
//  uiExamples
//
//  Created by David Martinez on 25/03/2017.
//  Copyright © 2017 Atenea. All rights reserved.
//

import UIKit

class WWDC2016AnimationsProject: NSObject, ProjectDispatcherInterface {
    
    static func getProject() throws -> Project {
        
        let builder = Project.Builder()
        builder.setName(name: "Advances in UIKit Animations and Transitions")
        builder.setNavigation(navigation: { (navigation: UINavigationController) in
            
            let storyboard = UIStoryboard(name: "WWDC2016Animations", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier :"WWDC2016AnimationsViewController")
            navigation.present(viewController, animated: true, completion: nil)
        })
        
        return try builder.build()
    }
}
