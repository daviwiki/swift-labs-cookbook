//
//  Section.swift
//  uiExamples
//
//  Created by David Martinez on 25/03/2017.
//  Copyright © 2017 Atenea. All rights reserved.
//

import Foundation

enum SectionBuilderError: Error {
    case nameNotDefined
}

class Section: NSObject {
    
    var name = ""
    var projects: [Project] = []
    
    class Builder: NSObject {
        
        private let section = Section()
        
        func setName(name: String) {
            section.name = name
        }
        
        func setProjects(projects: [Project]) {
            section.projects = projects
        }
        
        public func build() throws -> Section {
            guard section.name.characters.count > 0 else {
                throw SectionBuilderError.nameNotDefined
            }
            
            return section
        }
    }
}
