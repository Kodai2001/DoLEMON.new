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
    
    private let followingNumberButton: UIButton = {
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
    
    private let followersNumberButton: UIButton = {
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
        imageView.image = UIImage(named: "遠藤さくら")
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
        button.addTarget(self, action: #selector(didTappedEditProfileButton), for: .touchUpInside)
        return button
    }()

    override init(reuseIdentifier: String?) {
          super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .secondarySystemBackground
        addSubviews()
        let firestoreManager = FirestoreManager()
        firestoreManager.getUser { [self] results in
            fullNameLabel.text = results[0]
            accountNameLabel.text = "@\(results[3])"
        }
        
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
        fullNameLabel.frame.size.width = 200
        fullNameLabel.frame.size.height = 41
        fullNameLabel.frame.origin.x = 230
        fullNameLabel.frame.origin.y = 0
        
        // accountNameLabel
        accountNameLabel.frame.size.width = 200
        accountNameLabel.frame.size.height = 20
        accountNameLabel.frame.origin.x = 230
        accountNameLabel.frame.origin.y = 40
        
        // editProfileButton
        editProfileButton.frame.size.width = 200
        editProfileButton.frame.size.height = 45
        editProfileButton.frame.origin.x = 20
        editProfileButton.frame.origin.y = 125
        
        // profileImageView
        profileImageView.frame.size.width = 100
        profileImageView.frame.size.height = 100
        profileImageView.frame.origin.x = 250
        profileImageView.frame.origin.y = 75
    }
    
    // EditProfileButtonをタップしても反応しない
     @objc func didTappedEditProfileButton() {
        self.delegate?.editProfileButtonPressed()
     }
    
    
    
}
