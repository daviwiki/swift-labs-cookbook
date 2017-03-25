//
//  Project.swift
//  uiExamples
//
//  Created by David Martinez on 13/03/2017.
//  Copyright © 2017 Atenea. All rights reserved.
//

import UIKit

enum ProjectBuilderError: Error {
    case nameNotDefined
    case navigationNotDefined
}

class Project: NSObject {

    typealias Navigation = ((UINavigationController) -> Void)
    
    private(set) var name: String = ""
    private(set) var navigation: Navigation!
    
    class Builder: NSObject {
        
        let project = Project()
        
        func setName(name: String) {
            project.name = name
        }
        
        func setNavigation(navigation: @escaping Navigation) {
            project.navigation = navigation
        }
        
        func build() throws -> Project {
            
            guard project.name.characters.count > 0 else {
                throw ProjectBuilderError.nameNotDefined
            }
            
            guard project.navigation != nil else {
                throw ProjectBuilderError.navigationNotDefined
            }
            
            return project
        }
    }
}
