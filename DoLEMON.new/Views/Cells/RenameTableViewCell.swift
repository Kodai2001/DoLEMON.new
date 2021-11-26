//
//  RenameTableViewCell.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/18.
//

import UIKit

class RenameTableViewCell: UITableViewCell {
    
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "title"
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    let nameTextField: UITextField = {
       let textField = UITextField()
        textField.backgroundColor = .clear
        textField.layer.masksToBounds = true
        textField.borderStyle = .none
        textField.textColor = .label
        textField.font = .boldSystemFont(ofSize: 25)
        return textField
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        nameTextField.delegate = self
        contentView.addSubview(titleLabel)
        contentView.addSubview(nameTextField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // titleLabel
        titleLabel.frame.size.width = 200
        titleLabel.frame.size.height = 20
        titleLabel.frame.origin.x = 20
        titleLabel.frame.origin.y = 5
        
        // nameTextField
        nameTextField.frame.size.width = 500
        nameTextField.frame.size.height = 30
        nameTextField.frame.origin.x = 20
        nameTextField.frame.origin.y = titleLabel.frame.origin.y+25
    }
    
    func configureCell(titleLabel: String, nameTextField: String) {
        self.titleLabel.text = titleLabel
        self.nameTextField.text = nameTextField
    }
}

extension RenameTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let fullNameText = textField.text else { return }
        // firestoreを更新する
        guard let uid = FirebaseAuthManager.shared.userSession?.uid else { return }
        COLLECTION_USERS.document(uid).updateData(
            ["fullName" : fullNameText]
        )
    }
}
