//
//  UserPinPlaceTableViewCell.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/14.
//

import UIKit

class EditProfileTableViewCell: UITableViewCell {
    
    private let defaultTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let textUserCanChangeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .systemBlue
        return label
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = #colorLiteral(red: 0.6941176471, green: 1, blue: 0.9921568627, alpha: 1) 
        addSubviews()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        contentView.addSubview(defaultTitleLabel)
        contentView.addSubview(textUserCanChangeLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // defaultTitleLabel
        defaultTitleLabel.frame.size.width = 100
        defaultTitleLabel.frame.size.height = 30
        defaultTitleLabel.frame.origin.x = 20
        defaultTitleLabel.frame.origin.y = 17
    
        // textUserCanChangeLabel
        textUserCanChangeLabel.frame.size.width = 400
        textUserCanChangeLabel.frame.size.height = 30
        textUserCanChangeLabel.frame.origin.x = defaultTitleLabel.frame.origin.x+120
        textUserCanChangeLabel.frame.origin.y = 17
    }
    
    func configureCell(label: String, text: String) {
        defaultTitleLabel.text = label
        textUserCanChangeLabel.text = text
    }
    

}
