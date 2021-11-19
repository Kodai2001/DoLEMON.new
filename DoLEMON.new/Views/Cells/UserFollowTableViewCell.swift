//
//  UserFollowTableViewCell.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/14.
//

import UIKit

class UserFollowTableViewCell: UITableViewCell {
    
    private let profileImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "徳川家康")
        return imageView
    }()
    
    
    private let accountNameLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.text = "@tokugawa.Edo"
        return label
    }()
    
    private let fullNameLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.text = "徳川家康"
        return label
    }()
   
    private let followButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .white
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2.0
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(UIColor.black,for: .normal)
        button.setTitle("Following", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: 15,
            weight: .semibold
        )
        //button.addTarget(self, action: #selector(didTappedEditProfileButton), for: .touchUpInside)
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        contentView.backgroundColor = .systemBackground
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        contentView.addSubview(accountNameLabel)
        contentView.addSubview(fullNameLabel)
        contentView.addSubview(profileImageView)
        contentView.addSubview(followButton)
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
        
        // followButton
        followButton.frame.size.width = 120
        followButton.frame.size.height = 40
        followButton.frame.origin.x = fullNameLabel.frame.origin.x+130
        followButton.frame.origin.y = 15
    }
    
}
