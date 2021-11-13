//
//  SignUpViewController.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/11.
//


import UIKit

class RegisterViewController: UIViewController {
    
    private let createAccountButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.5725490196, blue: 0.7450980392, alpha: 1)
        button.layer.cornerRadius = 30.0
        button.setTitleColor(UIColor.white,for: .normal)
        button.setTitle("Create Account", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: 30,
            weight: .bold
        )
        //button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let emailTextField: UITextField = {
       let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 30.0
        textField.placeholder = "       Email"
        return textField
    }()
    
    private let fullNameTextField: UITextField = {
       let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 30.0
        textField.placeholder = "       Full Name"
        return textField
    }()
    
    private let userNamelTextField: UITextField = {
       let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 30.0
        textField.placeholder = "       Username"
        return textField
    }()
    
    private let passwordlTextField: UITextField = {
       let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 30.0
        textField.placeholder = "       Password"
        return textField
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.6941176471, green: 1, blue: 0.9921568627, alpha: 1)
        self.navigationItem.title = "SIGN UP"
        addSubviews()
    }
    
    private func addSubviews() {
        view.addSubview(createAccountButton)
        view.addSubview(emailTextField)
        view.addSubview(passwordlTextField)
        view.addSubview(userNamelTextField)
        view.addSubview(fullNameTextField)
    }
    
    override func viewDidLayoutSubviews() {
       
        
        // emailTextField
        emailTextField.frame.size.width = 300
        emailTextField.frame.size.height = 70
        emailTextField.frame.origin.x = self.view.frame.size.width / 2 - emailTextField.frame.size.width / 2
        emailTextField.frame.origin.y = view.safeAreaInsets.top + 20
        
        //fullNameTextField
        fullNameTextField.frame.size.width = 300
        fullNameTextField.frame.size.height = 70
        fullNameTextField.frame.origin.x = self.view.frame.size.width / 2 - fullNameTextField.frame.size.width / 2
        fullNameTextField.frame.origin.y = emailTextField.frame.origin.y + 100
        
        // userNamelTextField
        userNamelTextField.frame.size.width = 300
        userNamelTextField.frame.size.height = 70
        userNamelTextField.frame.origin.x = self.view.frame.size.width / 2 - userNamelTextField.frame.size.width / 2
        userNamelTextField.frame.origin.y = emailTextField.frame.origin.y + 200
        
        //passwordTextField
        passwordlTextField.frame.size.width = 300
        passwordlTextField.frame.size.height = 70
        passwordlTextField.frame.origin.x = self.view.frame.size.width / 2 - passwordlTextField.frame.size.width / 2
        passwordlTextField.frame.origin.y = emailTextField.frame.origin.y + 300
        
        // loginButton
        createAccountButton.frame.size.width = 300
        createAccountButton.frame.size.height = 70
        createAccountButton.frame.origin.x = self.view.frame.size.width / 2 - createAccountButton.frame.size.width / 2
        createAccountButton.frame.origin.y = emailTextField.frame.origin.y + 450
    }
}

