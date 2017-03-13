//
//  ProjectDispatcherInterface.swift
//  uiExamples
//
//  Created by David Martinez on 13/03/2017.
//  Copyright © 2017 Atenea. All rights reserved.
//

import UIKit

protocol ProjectDispatcherInterface {
    
    static func getProject() throws -> Project
    
}
