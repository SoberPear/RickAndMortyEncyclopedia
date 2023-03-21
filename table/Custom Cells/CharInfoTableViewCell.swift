//
//  CharInfoTableViewCell.swift
//  table
//
//  Created by Алексей Волобуев on 11.10.2022.
//

import UIKit

class CharInfoTableViewCell: UITableViewCell {

    let type = CustomCellType.info
    var nameLabel = UILabel()
    var statusLabel = UILabel()
    var speciesLabel = UILabel()
    var genderLabel = UILabel()
    
    public func configure() {
        self.addSubview(nameLabel)
        self.addSubview(statusLabel)
        self.addSubview(speciesLabel)
        self.addSubview(genderLabel)
        
        //nameLabel.adjustsFontSizeToFitWidth = true
        //nameLabel.contentMode = .center
        nameLabel.font = .boldSystemFont(ofSize: 30)
        statusLabel.font = .systemFont(ofSize: 20)
        speciesLabel.font = .systemFont(ofSize: 20)
        genderLabel.font = .systemFont(ofSize: 20)
        
        nameLabel.textColor = .black
        statusLabel.textColor = .black
        speciesLabel.textColor = .black
        genderLabel.textColor = .black
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        speciesLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        //nameLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true

        speciesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        speciesLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        speciesLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        genderLabel.topAnchor.constraint(equalTo: speciesLabel.bottomAnchor, constant: 10).isActive = true
        genderLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        genderLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        statusLabel.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 10).isActive = true
        statusLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        statusLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        statusLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
