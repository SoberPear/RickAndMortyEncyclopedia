//
//  PhotoTableViewCell.swift
//  table
//
//  Created by Алексей Волобуев on 10.10.2022.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    let type = CustomCellType.photo
    var myImageView = UIImageView()
    
    public func configure() {
        self.addSubview(myImageView)
        
        myImageView.translatesAutoresizingMaskIntoConstraints = false
//        myImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
//        myImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
//        myImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
//        myImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        myImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        myImageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        myImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        myImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        myImageView.contentMode = .scaleAspectFit
        myImageView.layer.cornerRadius = 5
        myImageView.clipsToBounds = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
