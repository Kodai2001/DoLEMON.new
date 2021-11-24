//
//  ProfileCustomHeaderView.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/14.
//

import UIKit
import Kingfisher



class ProfileCustomHeaderView: UITableViewHeaderFooterView {
    
    let followingNumberButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .clear
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.setTitleColor(UIColor.black,for: .normal)
        button.setTitle("100", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: 25,
            weight: .bold
        )
        //button.addTarget(self, action: #selector(didTappedEditProfileButton), for: .touchUpInside)
        return button
    }()
    
    private let followingTextButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .clear
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.setTitleColor(UIColor.black,for: .normal)
        button.setTitle("Following", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: 15,
            weight: .semibold
        )
        //button.addTarget(self, action: #selector(didTappedEditProfileButton), for: .touchUpInside)
        return button
    }()
    
    let followersNumberButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .clear
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.setTitleColor(UIColor.black,for: .normal)
        button.setTitle("7890", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: 25,
            weight: .bold
        )
        //button.addTarget(self, action: #selector(didTappedEditProfileButton), for: .touchUpInside)
        return button
    }()
    
    private let followersTextButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .clear
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.setTitleColor(UIColor.black,for: .normal)
        button.setTitle("Followers", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: 15,
            weight: .semibold
        )
        //button.addTarget(self, action: #selector(didTappedEditProfileButton), for: .touchUpInside)
        return button
    }()
    
    private let profileImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let fullNameLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let accountNameLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()

    
    let editProfileButton: UIButton = {
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
        return button
    }()

    //MARK: - Init
    
    override init(reuseIdentifier: String?) {
          super.init(reuseIdentifier: reuseIdentifier)
        addSubviews()
        let firestoreManager = FirestoreManager()
        
        firestoreManager.fetchUser { [self] result in
            fullNameLabel.text = result.fullName
            accountNameLabel.text = result.username
            let url = URL(string: result.profileImageURL)
            profileImageView.kf.setImage(with: url)
        }
         
        clipsToBounds = true
        contentView.backgroundColor = #colorLiteral(red: 0.6941176471, green: 1, blue: 0.9921568627, alpha: 1) 
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(fullNameLabel)
        contentView.addSubview(accountNameLabel)
        contentView.addSubview(editProfileButton)
        contentView.addSubview(followingTextButton)
        contentView.addSubview(followersTextButton)
        contentView.addSubview(followingNumberButton)
        contentView.addSubview(followersNumberButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // followingNumberButton
        followingNumberButton.frame.size.width = 90
        followingNumberButton.frame.size.height = 90
        followingNumberButton.frame.origin.x = 125
        followingNumberButton.frame.origin.y = 0
        
        // followersNumberButton
        followersNumberButton.frame.size.width = 90
        followersNumberButton.frame.size.height = 90
        followersNumberButton.frame.origin.x = 20
        followersNumberButton.frame.origin.y = 0
        
        // followingButton
        followingTextButton.frame.size.width = 90
        followingTextButton.frame.size.height = 90
        followingTextButton.frame.origin.x = 125
        followingTextButton.frame.origin.y = 30
        
        // followersButton
        followersTextButton.frame.size.width = 90
        followersTextButton.frame.size.height = 90
        followersTextButton.frame.origin.x = 20
        followersTextButton.frame.origin.y = 30
        
        // fullNameLabel
        fullNameLabel.frame.size.width = 100
        fullNameLabel.frame.size.height = 41
        fullNameLabel.frame.origin.x = 230
        fullNameLabel.frame.origin.y = 30
        
        // accountNameLabel
        accountNameLabel.frame.size.width = 100
        accountNameLabel.frame.size.height = 31
        accountNameLabel.frame.origin.x = 230
        accountNameLabel.frame.origin.y = fullNameLabel.frame.origin.y+40
        
        // editProfileButton
        editProfileButton.frame.size.width = 200
        editProfileButton.frame.size.height = 45
        editProfileButton.frame.origin.x = 20
        editProfileButton.frame.origin.y = 110
        
        // profileImageView
        profileImageView.frame.size.width = 100
        profileImageView.frame.size.height = 100
        profileImageView.frame.origin.x = 250
        profileImageView.frame.origin.y = editProfileButton.frame.origin.y
    }
}
