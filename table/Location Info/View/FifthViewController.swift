//
//  FifthViewController.swift
//  table
//
//  Created by Алексей Волобуев on 13.10.2022.
//

import UIKit

protocol FifthViewInputDelegate: AnyObject {
    func setupLocation(location: Location)
    func setupResidents(chars: [CharacterViewModel])
    func configureLabels()
}

class FifthViewController: UIViewController {
    var outputDelegate: FifthViewOutputDelegate?
    var location: Location?
    var charSource: [CharacterViewModel]?
    let tableView = UITableView(frame: .zero, style: .plain)

    let regCellId = "regCell"
    
    var nameLabel = UILabel()
    var typeLabel = UILabel()
    var dimensionLabel = UILabel()
    let residentsLabel = UILabel()
    
    var name = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.outputDelegate?.getLocationInfo() {
            
        }
        createTable()
        view.addSubview(tableView)
        view.addSubview(nameLabel)
        view.addSubview(typeLabel)
        view.addSubview(dimensionLabel)
        view.addSubview(residentsLabel)
        addConstraints()
        
    }
    
    func createTable() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: regCellId)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 70
    }
    
    func addConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: residentsLabel.bottomAnchor, constant: 20).isActive = true
        tableView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        dimensionLabel.translatesAutoresizingMaskIntoConstraints = false
        residentsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        typeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        typeLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        dimensionLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 10).isActive = true
        dimensionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dimensionLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        residentsLabel.topAnchor.constraint(equalTo: dimensionLabel.bottomAnchor, constant: 10).isActive = true
        residentsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        residentsLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        residentsLabel.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -20).isActive = true
    }
}

extension FifthViewController: UITableViewDelegate, UITableViewDataSource, FifthViewInputDelegate {
    func configureLabels() {
        nameLabel.textColor = .black
        typeLabel.textColor = .black
        dimensionLabel.textColor = .black
        residentsLabel.textColor = .black
        
        nameLabel.font = .boldSystemFont(ofSize: 30)
        typeLabel.font = .systemFont(ofSize: 20)
        dimensionLabel.font = .systemFont(ofSize: 20)
        residentsLabel.font = .boldSystemFont(ofSize: 25)
        
        nameLabel.text = location?.name
        typeLabel.text = "Type: \(location?.type ?? "")"
        dimensionLabel.text = "Dimension: \(location?.dimension ?? "")"
        residentsLabel.text = "Residents:"
        
        self.title = location?.name
    }
    
    func setupResidents(chars: [CharacterViewModel]) {
        self.charSource = chars
        self.tableView.reloadData()
    }
    
    func setupLocation(location: Location) {
        self.location = location
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: regCellId, for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.image = charSource?[indexPath.row].image
        content.imageProperties.cornerRadius = 35
        content.text = charSource?[indexPath.row].name
        cell.contentConfiguration = content
        return cell
    }
    
}

