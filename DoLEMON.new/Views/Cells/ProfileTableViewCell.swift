//
//  ProfileTableViewCell.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/15.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    private let cellIcon: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "person.fill.badge.plus")
        return imageView
    }()
    
    private let cellLabel: UILabel = {
       let label = UILabel()
        label.text = "Add Friend"
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cellIcon)
        contentView.addSubview(cellLabel)
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        // cellIcon
        cellIcon.frame.size.width = 30
        cellIcon.frame.size.height = 30
        cellIcon.frame.origin.x = 20
        cellIcon.frame.origin.y = 0
        
        // cellLabel
        cellLabel.frame.size.width = 200
        cellLabel.frame.size.height = 30
        cellLabel.frame.origin.x = 60
        cellLabel.frame.origin.y = 0
    }
    
    
    
}