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
        return imageView
    }()
    
    private let cellLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cellIcon)
        contentView.addSubview(cellLabel)
        contentView.backgroundColor = .systemBackground

        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // cellIcon
        cellIcon.frame.size.width = 30
        cellIcon.frame.size.height = 30
        cellIcon.frame.origin.x = 20
        cellIcon.frame.origin.y = 15
        
        // cellLabel
        cellLabel.frame.size.width = 200
        cellLabel.frame.size.height = 30
        cellLabel.frame.origin.x = 70
        cellLabel.frame.origin.y = 15
    }
    
    func configureCell(label: String, icon: UIImage) {
        cellLabel.text = label
        cellIcon.image = icon
    }
    
}
