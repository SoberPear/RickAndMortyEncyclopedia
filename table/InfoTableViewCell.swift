//
//  InfoTableViewCell.swift
//  table
//
//  Created by Алексей Волобуев on 12.10.2022.
//

import UIKit

class InfoTableViewCell: UITableViewCell {

    let type = CustomCellType.info
    var name = UILabel()
    var status = UILabel()
    var species = UILabel()
    var gender = UILabel()
    
    public func configure() {
        name.font = .boldSystemFont(ofSize: 15)
        status.font = .boldSystemFont(ofSize: 15)
        species.font = .boldSystemFont(ofSize: 15)
        gender.font = .boldSystemFont(ofSize: 15)
        
        name.textColor = .black
        status.textColor = .black
        species.textColor = .black
        gender.textColor = .black
        
        self.addSubview(name)
        self.addSubview(status)
        self.addSubview(species)
        self.addSubview(gender)
        
        name.translatesAutoresizingMaskIntoConstraints = false
        species.translatesAutoresizingMaskIntoConstraints = false
        gender.translatesAutoresizingMaskIntoConstraints = false
        status.translatesAutoresizingMaskIntoConstraints = false
        
        name.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        name.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        name.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        name.bottomAnchor.constraint(equalTo: species.topAnchor, constant: -8).isActive = true
        
        species.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 8).isActive = true
        species.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        species.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        species.bottomAnchor.constraint(equalTo: gender.topAnchor, constant: -8).isActive = true
        
        gender.topAnchor.constraint(equalTo: species.bottomAnchor, constant: 8).isActive = true
        gender.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        gender.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        gender.bottomAnchor.constraint(equalTo: status.topAnchor, constant: -8).isActive = true
        
        status.topAnchor.constraint(equalTo: gender.bottomAnchor, constant: 8).isActive = true
        status.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        status.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        status.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
