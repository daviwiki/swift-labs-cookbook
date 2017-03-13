//
//  ProjectDispatcherViewController.swift
//  uiExamples
//
//  Created by David Martinez on 12/03/2017.
//  Copyright © 2017 Atenea. All rights reserved.
//

import UIKit

protocol ProjectDispatcherView: NSObjectProtocol {
    
    func showProjects(projects: [Project])
}

class ProjectDispatcherViewController: UIViewController, ProjectDispatcherView,
UITableViewDataSource, UITableViewDelegate {
    
    private var presenter: ProjectDispatcherPresenter!
    private var projects: [Project] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let getProjects = GetProjectListInteractor()
        presenter = ProjectDispatcherPresenter(getProjects: getProjects)
    }
    
    func showProjects(projects: [Project]) {
        self.projects = projects
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectcell", for: indexPath) as! ProjectCell
        let project = projects[indexPath.row]
        cell.showProject(project: project)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
