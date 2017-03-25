//
//  GetProjectListInteractor.swift
//  uiExamples
//
//  Created by David Martinez on 13/03/2017.
//  Copyright © 2017 Atenea. All rights reserved.
//

import UIKit

class GetProjectListInteractor: NSObject {

    func getProjects(callback:@escaping ([Section]) -> Void) {
        
        let qos = DispatchQoS.QoSClass.background
        DispatchQueue.global(qos: qos).async { [unowned self] in
            
            var sections : [Section] = []
            
            if let appFrameworkSection = self.getAppFrameworksSection() {
                sections.append(appFrameworkSection)
            }
            
            if let appDesignSection = self.getAppDesignSection() {
                sections.append(appDesignSection)
            }
            
            if let developerToolsSection = self.getDeveloperToolsSection() {
                sections.append(developerToolsSection)
            }
            
            if let graphicsAndGamesSection = self.getGraphicsAndGamesSection() {
                sections.append(graphicsAndGamesSection)
            }
            
            if let systemFrameworksSection = self.getSystemFrameworksSection() {
                sections.append(systemFrameworksSection)
            }
            
            DispatchQueue.main.async {
                callback(sections)
            }
        }
        
    }
    
    private func getAppFrameworksSection() -> Section? {
        
        var projects: [Project] = []
        
        do {
            try projects.append(PinterestProjectDefinition.getProject())
        } catch {
            print("[GetProjectList] Project couldn't be added due to: \(error)")
        }
        
        let sectionBuilder = Section.Builder()
        sectionBuilder.setName(name: "App Frameworks")
        sectionBuilder.setProjects(projects: projects)
        
        do {
            return try sectionBuilder.build()
        } catch {
            print("[GetProjectList] Section couldn't be added due to: \(error)")
        }
        
        return nil
    }
    
    private func getAppDesignSection() -> Section? {
        return nil
    }
    
    private func getDeveloperToolsSection() -> Section? {
        return nil
    }
    
    private func getGraphicsAndGamesSection() -> Section? {
        return nil
    }
    
    private func getSystemFrameworksSection() -> Section? {
        return nil
    }
}
