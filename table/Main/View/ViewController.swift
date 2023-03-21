//
//  ViewController.swift
//  table
//
//  Created by Алексей Волобуев on 29.09.2022.
//

import UIKit

protocol ViewInputDelegate: AnyObject {
    func setupData(data: [Episode])
}

class ViewController: UIViewController {
    
    let cellId = "Cell"
    let tableController = UITableViewController(style: .plain)
    private var dataSource = [Episode]()
    var viewOtputDelegate: ViewOutputDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Main"
        self.viewOtputDelegate?.getData()
        createTableView()
        view.addSubview(tableController.tableView)
        addConstraints()
    }
    
    func createTableView () {
        tableController.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableController.tableView.delegate = self
        tableController.tableView.dataSource = self
        tableController.tableView.rowHeight = 100
    }
    
    func addConstraints () {
        tableController.tableView.translatesAutoresizingMaskIntoConstraints = false
        let safeGuide = self.view.safeAreaLayoutGuide
        tableController.tableView.topAnchor.constraint(equalTo: safeGuide.topAnchor).isActive = true
        tableController.tableView.leftAnchor.constraint(equalTo: safeGuide.leftAnchor).isActive = true
        tableController.tableView.rightAnchor.constraint(equalTo: safeGuide.rightAnchor).isActive = true
        tableController.tableView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewOtputDelegate?.didSelectCell(id: indexPath.row)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, ViewInputDelegate {
    
    func setupData(data: [Episode]) {
        self.dataSource = data
        tableController.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        content.text = dataSource[indexPath.row].name
        content.secondaryText = dataSource[indexPath.row].episode + ": " + dataSource[indexPath.row].airDate
        
        cell.contentConfiguration = content
        
        return cell
    }
}
