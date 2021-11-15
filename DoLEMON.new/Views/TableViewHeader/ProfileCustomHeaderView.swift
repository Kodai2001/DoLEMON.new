//
//  ProfileCustomHeaderView.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/14.
//

import UIKit

protocol ProfileCustomHeaderViewDelegate: AnyObject  {
    func editProfileButtonPressed()
}

class ProfileCustomHeaderView: UITableViewHeaderFooterView {
    
    public weak var delegate: ProfileCustomHeaderViewDelegate?
    
    private let profileImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "遠藤さくら")
        return imageView
    }()
    
    private let fullNameLabel: UILabel = {
       let label = UILabel()
        label.text = "Kodai Hayashi"
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let accountNameLabel: UILabel = {
       let label = UILabel()
        label.text = "@Erizabesu_Japan"
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()

    
    private let editProfileButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .clear
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.setTitleColor(UIColor.black,for: .normal)
        button.layer.borderWidth = 2.0
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle("Edit Profile", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: 30,
            weight: .bold
        )
        button.addTarget(self, action: #selector(editProfileButtonPressed), for: .touchUpInside)
        return button
    }()

    override init(reuseIdentifier: String?) {
          super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .secondarySystemBackground
        addSubviews()
        
        
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(fullNameLabel)
        contentView.addSubview(accountNameLabel)
        contentView.addSubview(editProfileButton)
    }
    
    override func layoutSubviews() {
        
        // fullNameLabel
        fullNameLabel.frame.size.width = 200
        fullNameLabel.frame.size.height = 41
        fullNameLabel.frame.origin.x = 20
        fullNameLabel.frame.origin.y = 30
        
        // accountNameLabel
        accountNameLabel.frame.size.width = 200
        accountNameLabel.frame.size.height = 20
        accountNameLabel.frame.origin.x = 20
        accountNameLabel.frame.origin.y = 70
        
        // editProfileButton
        editProfileButton.frame.size.width = 200
        editProfileButton.frame.size.height = 45
        editProfileButton.frame.origin.x = 20
        editProfileButton.frame.origin.y = 125
        
        // profileImageView
        profileImageView.frame.size.width = 100
        profileImageView.frame.size.height = 100
        profileImageView.frame.origin.x = 250
        profileImageView.frame.origin.y = 30
    }
    
     @objc func editProfileButtonPressed() {
        delegate?.editProfileButtonPressed()
    }
    
    
    
}
