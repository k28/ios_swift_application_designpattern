//
//  TaskListViewController.swift
//  mvc_task
//
//  Created by kazuya on 2019/10/06.
//  Copyright © 2019 K.Hatano. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController {

    fileprivate var tableView: UITableView!
    fileprivate var tasks = [Task]()

    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TaskListCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        
        view.backgroundColor = UIColor.red
        
        let barButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(barButtonTrapped(_:)))
        navigationItem.rightBarButtonItem = barButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tasks = RealmManager.getAllTasks()
        tableView.reloadData()
    }
    
    @objc func barButtonTrapped(_ sender: UIBarButtonItem) {
        let latestId = String(tasks.count + 1)
        let controller = CreateTaskViewController(latestId: latestId)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TaskListCell
        
        let task = tasks[indexPath.row]
        
        cell.task = task
        return cell
    }
}
