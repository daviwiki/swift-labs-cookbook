//
//  ProjectDispatcherViewController.swift
//  uiExamples
//
//  Created by David Martinez on 12/03/2017.
//  Copyright © 2017 Atenea. All rights reserved.
//

import UIKit

protocol ProjectDispatcherView: NSObjectProtocol {
    
    func showSections(sections: [Section])
}

class ProjectDispatcherViewController: UIViewController, ProjectDispatcherView,
UITableViewDataSource, UITableViewDelegate {
    
    private var presenter: ProjectDispatcherPresenter!
    private var sections: [Section] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let getProjects = GetProjectListInteractor()
        presenter = ProjectDispatcherPresenter(getProjects: getProjects)
    }
    
    func showSections(sections: [Section]) {
        self.sections = sections
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.bind(view: self)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.loadProjects()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sec = sections[section]
        return sec.projects.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sec = sections[section]
        return sec.name
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.row]
        let projects = section.projects
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectcell", for: indexPath) as! ProjectCell
        let project = projects[indexPath.row]
        cell.showProject(project: project)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = sections[indexPath.row]
        let projects = section.projects
        let project = projects[indexPath.row]
        
        guard let navigationController = self.navigationController else { return }
        guard let route = project.navigation else { return }
        route(navigationController)
    }
}

class ProjectCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func showProject(project: Project) {
        nameLabel.text = project.name
    }
}

class HeaderCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func showSection(section: Section) {
        nameLabel.text = section.name
    }
}
