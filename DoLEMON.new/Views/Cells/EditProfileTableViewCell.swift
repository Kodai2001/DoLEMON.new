//
//  UserPinPlaceTableViewCell.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/14.
//

import UIKit

class EditProfileTableViewCell: UITableViewCell {
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "FullName"
        return label
    }()
    
    private let fullNameText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "Sakura Endo"
        label.textColor = .systemBlue
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "Username"
        return label
    }()
    
    private let usernameText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "@Nogizaka46.SonyJapan"
        label.textColor = .secondaryLabel
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
        contentView.addSubview(fullNameLabel)
        contentView.addSubview(fullNameText)
        //contentView.addSubview(usernameText)
        //contentView.addSubview(usernameLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // fullNameLabel
        fullNameLabel.frame.size.width = 100
        fullNameLabel.frame.size.height = 30
        fullNameLabel.frame.origin.x = 20
        fullNameLabel.frame.origin.y = 0
    
        // fullNameText
        fullNameText.frame.size.width = 400
        fullNameText.frame.size.height = 30
        fullNameText.frame.origin.x = fullNameLabel.frame.origin.x+120
        fullNameText.frame.origin.y = 0
    }
    

}
