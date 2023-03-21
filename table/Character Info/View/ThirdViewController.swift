//
//  ThirdViewController.swift
//  table
//
//  Created by Алексей Волобуев on 10.10.2022.
//

import UIKit

protocol ThirdViewInputDelegate: AnyObject {
    func setupSharInfo(charInfo: CharacterInfoViewModel) 
}

class ThirdViewController: UIViewController {
    var charInfo: CharacterInfoViewModel?
    
    var viewOtputDelegate: ThirdViewOutputDelegate?
    
    var tableOrder: [CustomCellType] = []
    
    var name = String()
    let tableView = UITableView(frame: .zero, style: .plain)

    let photoCellId = "photoCell"
    let infCellId = "infCell"
    let epCellId = "epCell"
    let locCellId = "locCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableOrder = [.photo, .info, .episodes, .location, .location]
        self.viewOtputDelegate?.getCharInfo() {
            
        }
        self.title = name
        
        createTable()
        view.addSubview(tableView)
        addConstraints()
        
    }
    
    func createTable () {
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: photoCellId)
        tableView.register(CharInfoTableViewCell.self, forCellReuseIdentifier: infCellId)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: epCellId)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: locCellId)
        tableView.dataSource = self
        tableView.delegate = self
        
        
    }
     
    func addConstraints () {
        let safeArea = self.view.safeAreaLayoutGuide
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableOrder[indexPath.row] {
        case .photo: break
        case .info: break
        case .episodes:
            self.viewOtputDelegate?.didSelectEpCell()
        case .location:
            if indexPath.row == 3 && charInfo?.origin.name == "unknown" {
                break
            }
            if indexPath.row == 3 && charInfo?.origin.name != "unknown" {
                self.viewOtputDelegate?.didSelectLocCell(type: 0)
            }
            if indexPath.row == 4 && charInfo?.location.name == "unknown" {
                break
            }
            if indexPath.row == 4 && charInfo?.origin.name != "unknown" {
                self.viewOtputDelegate?.didSelectLocCell(type: 1)
            }
        }
    }

    
}

extension ThirdViewController: UITableViewDelegate, UITableViewDataSource, ThirdViewInputDelegate {
    func setupSharInfo(charInfo: CharacterInfoViewModel) {
        self.charInfo = charInfo
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableOrder[indexPath.row] {
        case .photo:
            return 300
        case .info:
            return 180
        case .episodes:
            return 50
        case .location:
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableOrder[indexPath.row] {
        case .photo:
            let cell = tableView.dequeueReusableCell(withIdentifier: photoCellId, for: indexPath) as! PhotoTableViewCell
            cell.configure()
            cell.myImageView.image = charInfo?.image
            return cell
        case .info:
            let cell = tableView.dequeueReusableCell(withIdentifier: infCellId, for: indexPath) as! CharInfoTableViewCell
            cell.configure()
            cell.nameLabel.text = charInfo?.name
            cell.genderLabel.text = "Gender: \(charInfo?.gender ?? "")"
            cell.speciesLabel.text = "Species: \(charInfo?.species ?? "")"
            cell.statusLabel.text = "Status: \(charInfo?.status ?? "")"
            return cell
        case .episodes:
            let cell = tableView.dequeueReusableCell(withIdentifier: epCellId, for: indexPath)
            var content = cell.defaultContentConfiguration()
            content.text = "All character episodes"
            cell.contentConfiguration = content
            cell.accessoryType = .disclosureIndicator
            return cell
        case .location:
            let cell = tableView.dequeueReusableCell(withIdentifier: locCellId, for: indexPath)
            var content = cell.defaultContentConfiguration()
            if indexPath.row == 3 {
                content.text = "Origin location: \(charInfo?.origin.name ?? "")"
            } else {
                content.text = "Last known location: \(charInfo?.location.name ?? "")"
            }
            cell.contentConfiguration = content
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
}
