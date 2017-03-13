//
//  GetProjectListInteractor.swift
//  uiExamples
//
//  Created by David Martinez on 13/03/2017.
//  Copyright © 2017 Atenea. All rights reserved.
//

import UIKit

class GetProjectListInteractor: NSObject {

    func getProjects(callback:@escaping ([Project]) -> Void) {
        
        let qos = DispatchQoS.QoSClass.background
        DispatchQueue.global(qos: qos).async { [unowned self] in
            
            var projects : [Project] = []
            projects.append(contentsOf: self.getCollectionViewProjects())
            
            DispatchQueue.main.async {
                callback(projects)
            }
        }
        
    }
    
    private func getCollectionViewProjects() -> [Project] {
        var projects: [Project] = []
        
        do {
            try projects.append(PinterestProjectDefinition.getProject())
        } catch {
            print("[GetProjectList] Project couldn't be added due to: \(error)")
        }
        
        return projects
    }
    
}
