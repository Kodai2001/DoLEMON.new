//
//  SearchFriendViewController.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/11.
//

import UIKit

class SearchFriendViewController: UIViewController {
    
    private let usernameTextField: UITextField = {
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.boldSystemFont(ofSize: 7.0),
            .foregroundColor : UIColor.lightGray
        ]
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.layer.masksToBounds = true
        textField.attributedPlaceholder = NSAttributedString(string: "Enter User ID",
                                                             attributes: attributes)
        textField.font = .boldSystemFont(ofSize: 30.0)
        textField.textAlignment = .center
        return textField
    }()
    
    private let checkButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.5725490196, blue: 0.7450980392, alpha: 1)
        button.layer.cornerRadius = 10.0
        button.setTitleColor(UIColor.white,for: .normal)
        button.setTitle("OK", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: 30,
            weight: .bold
        )
        button.addTarget(self, action: #selector(checkButtonPressed), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.6941176471, green: 1, blue: 0.9921568627, alpha: 1)
        self.navigationItem.title = "Search Friend"
        usernameTextField.delegate = self
        
        view.addSubview(usernameTextField)
        view.addSubview(checkButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // usernameTextField
        usernameTextField.frame.size.width = 300
        usernameTextField.frame.size.height = 100
        usernameTextField.frame.origin.x = self.view.frame.size.width / 2 - usernameTextField.frame.size.width / 2
        usernameTextField.frame.origin.y = usernameTextField.frame.origin.y + 300
        
        // checkButton
        checkButton.frame.size.width = 100
        checkButton.frame.size.height = 80
        checkButton.frame.origin.x = self.view.frame.size.width / 2 - checkButton.frame.size.width / 2
        checkButton.frame.origin.y = checkButton.frame.origin.y + 450
    }
    
    @objc func checkButtonPressed() {
        
        if usernameTextField.text != nil {
            guard let uid = usernameTextField.text else { return }
            
            FirestoreManager.shared.searchUser(uid: uid) { user in
                
                let vc = AddFriendViewController()
                vc.user = user
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        else {
            let alert = UIAlertController(title: nil, message: "Please enter User ID", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK!!!", style: .default, handler: nil)
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension SearchFriendViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
