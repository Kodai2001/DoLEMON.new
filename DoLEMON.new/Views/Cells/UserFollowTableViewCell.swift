//
//  UserFollowTableViewCell.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/14.
//

import UIKit
import Kingfisher

class UserFollowTableViewCell: UITableViewCell {
    
    let profileImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    let accountNameLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let fullNameLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        contentView.addSubview(accountNameLabel)
        contentView.addSubview(fullNameLabel)
        contentView.addSubview(profileImageView)
        // contentView.addSubview(followFollowingButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // profileImageView
        profileImageView.frame.size.width = 60
        profileImageView.frame.size.height = 60
        profileImageView.frame.origin.x = 20
        profileImageView.frame.origin.y = 10
        
        // accountNameLabel
        accountNameLabel.frame.size.width = 100
        accountNameLabel.frame.size.height = 30
        accountNameLabel.frame.origin.x = profileImageView.frame.origin.x+70
        accountNameLabel.frame.origin.y = 15
        
        // fullNameLabel
        fullNameLabel.frame.size.width = 100
        fullNameLabel.frame.size.height = 30
        fullNameLabel.frame.origin.x = profileImageView.frame.origin.x+70
        fullNameLabel.frame.origin.y = accountNameLabel.frame.origin.y + 25
    }
    
}
