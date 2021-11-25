//
//  EditProfileCustomHeaderView.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/18.
//

import UIKit

class EditProfileCustomHeaderView: UITableViewHeaderFooterView {
    
    let profileImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 60
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "遠藤さくら")
        return imageView
    }()
    
    let changeButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .clear
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor.systemBlue,for: .normal)
        button.setTitle("Change Profile Photo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: 20,
            weight: .bold
        )
        
        return button
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = #colorLiteral(red: 0.6941176471, green: 1, blue: 0.9921568627, alpha: 1) 
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(changeButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // profileImageView
        profileImageView.frame.size.width = 120
        profileImageView.frame.size.height = 120
        // 真ん中にしたい
        profileImageView.frame.origin.x = contentView.frame.size.width/2-profileImageView.frame.size.width/2
        profileImageView.frame.origin.y = 50
        
        // changeButton
        changeButton.frame.size.width = 300
        changeButton.frame.size.height = 50
        // 真ん中にしたい
        changeButton.frame.origin.x = contentView.frame.size.width/2-changeButton.frame.size.width/2
        changeButton.frame.origin.y = profileImageView.frame.origin.y + 130
    }
}

