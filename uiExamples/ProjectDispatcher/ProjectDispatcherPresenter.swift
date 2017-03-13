//
//  ProjectDispatcherPresenter.swift
//  uiExamples
//
//  Created by David Martinez on 13/03/2017.
//  Copyright © 2017 Atenea. All rights reserved.
//

import UIKit

class ProjectDispatcherPresenter: NSObject {

    private weak var view: ProjectDispatcherView?
    private var getProjects: GetProjectListInteractor!
    
    init(getProjects: GetProjectListInteractor) {
        self.getProjects = getProjects
    }
    
    func bind(view: ProjectDispatcherView) {
        self.view = view
    }
    
    func loadProjects() {
        
        getProjects.getProjects { (projects: [Project]) in
            self.view?.showProjects(projects: projects)
        }
        
    }
    
}
