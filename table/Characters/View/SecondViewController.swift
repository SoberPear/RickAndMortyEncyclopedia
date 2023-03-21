//
//  SecondViewController.swift
//  table
//
//  Created by Алексей Волобуев on 30.09.2022.
//

import UIKit

protocol SecondViewInputDelegate: AnyObject {
    func setupViewModel(_ charModelArray: [CharacterViewModel])
}

class SecondViewController: UIViewController {
    
    var viewOtputDelegate: SecondViewOutputDelegate?
    
    let loadingView = UIView()
    let tableView = UITableView(frame: .zero, style: .plain)
    let secondCellId = "secondCell"
    
    var viewTitle = String()
    
    var charModelSource = [CharacterViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadingView.startAnimation
        self.viewOtputDelegate?.getChars() {
            //loadingView.stopAnimation
        }
        self.title = viewTitle
        createTable()
        view.addSubview(tableView)
        createConstraints()       
    }
    
    func createTable () {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: secondCellId)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 100
    }
    
    func createConstraints () {
        let safeGuide = self.view.safeAreaLayoutGuide
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rightAnchor.constraint(equalTo: safeGuide.rightAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: safeGuide.leftAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: safeGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor).isActive = true
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewOtputDelegate?.didSelectСell(id: indexPath.row)
    }
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource, SecondViewInputDelegate {
    
    func setupViewModel(_ charModelArray: [CharacterViewModel]) {
        self.charModelSource = charModelArray
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charModelSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: secondCellId, for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = charModelSource[indexPath.row].name
        content.image = charModelSource[indexPath.row].image
        content.imageProperties.cornerRadius = 50
        cell.contentConfiguration = content
        
        return cell
    }
}
