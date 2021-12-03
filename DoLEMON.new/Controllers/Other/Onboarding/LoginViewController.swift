//
//  LoginViewController.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/11.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let loginButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.5725490196, blue: 0.7450980392, alpha: 1)
        button.layer.cornerRadius = 30.0
        button.setTitleColor(UIColor.white,for: .normal)
        button.setTitle("LOGIN", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: 30,
            weight: .bold
        )
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let emailTextField: UITextField = {
       let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 30.0
        textField.placeholder = "       Email"
        return textField
    }()
    
    private let passwordlTextField: UITextField = {
       let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 30.0
        textField.placeholder = "       Password"
        return textField
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.6941176471, green: 1, blue: 0.9921568627, alpha: 1)
        self.navigationItem.title = "LOGIN"
        emailTextField.delegate = self
        passwordlTextField.delegate = self
        addSubviews()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    // textViewをキーボード共に上げる
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= 50
            } else {
                let suggestionHeight = self.view.frame.origin.y + keyboardSize.height
                self.view.frame.origin.y -= suggestionHeight
            }
        }
    }
    
    // textViewをキーボード共に下げる
    @objc func keyboardWillHide() {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    private func addSubviews() {
        view.addSubview(loginButton)
        view.addSubview(emailTextField)
        view.addSubview(passwordlTextField)
    }
    
    override func viewDidLayoutSubviews() {
       
        
        // emailTextField
        emailTextField.frame.size.width = 300
        emailTextField.frame.size.height = 70
        emailTextField.frame.origin.x = self.view.frame.size.width / 2 - emailTextField.frame.size.width / 2
        emailTextField.frame.origin.y = view.safeAreaInsets.top + 50
        
        //passwordTextField
        passwordlTextField.frame.size.width = 300
        passwordlTextField.frame.size.height = 70
        passwordlTextField.frame.origin.x = self.view.frame.size.width / 2 - passwordlTextField.frame.size.width / 2
        passwordlTextField.frame.origin.y = emailTextField.frame.origin.y + 120
        
        // loginButton
        loginButton.frame.size.width = 300
        loginButton.frame.size.height = 70
        loginButton.frame.origin.x = self.view.frame.size.width / 2 - loginButton.frame.size.width / 2
        loginButton.frame.origin.y = emailTextField.frame.origin.y + 300
    }
    
    @objc func loginButtonPressed() {
        let loginManager = FirebaseAuthManager()
        guard let email = emailTextField.text, let password = passwordlTextField.text else { return }
        loginManager.signIn(email: email, password: password) {[weak self] (success) in
            guard let `self` = self else { return }
            var message: String = ""
            
            if (success) {
                print("User was sucessfully logged in.")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let TabBarController = storyboard.instantiateViewController(identifier: "onboardingVC")
                TabBarController.modalPresentationStyle = .fullScreen
                self.present(TabBarController, animated: true, completion: nil)
            } else {
                message = "There was an error."
                print( "There was an error.")
                let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true)
            }
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
