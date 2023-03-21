//
//  FourthViewController.swift
//  table
//
//  Created by Алексей Волобуев on 13.10.2022.
//

import UIKit

protocol FourthViewInputDelegate: AnyObject {
    func setupEpisodes(episodes: [Episode])
}

class FourthViewController: UIViewController {
    
    var outputDelegate: FourthViewOutputDelegate?
    var epSource = [Episode]()
    let tableView = UITableView(frame: .zero, style: .plain)
    var name = String()
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.outputDelegate?.getEpisodes() {
            
        }
        self.title = "Episodes with \(name)"
        createTable()
        view.addSubview(tableView)
        addConstraints()
        
    }
    
    func createTable() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
    }
    
    func addConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
    }
   

}

extension FourthViewController: UITableViewDelegate, UITableViewDataSource, FourthViewInputDelegate {
    func setupEpisodes(episodes: [Episode]) {
        self.epSource = episodes
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return epSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = "\(epSource[indexPath.row].episode): \(epSource[indexPath.row].name)"
        cell.contentConfiguration = content
        return cell
    }
}
