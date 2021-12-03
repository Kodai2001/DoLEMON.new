//
//  SignUpViewController.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/11.
//


import UIKit


class RegisterViewController: UIViewController {
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 60
        return imageView
    }()
    
    private let addProfileImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Profile Photo", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(didTapAddProfileImageButton), for: .touchUpInside)
        return button
    }()
    
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
        button.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10.0
        textField.placeholder = "       Email"
        return textField
    }()
    
    private let fullNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10.0
        textField.placeholder = "       Full Name"
        return textField
    }()
    
    private let userNamelTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10.0
        textField.placeholder = "       Username"
        return textField
    }()
    
    private let passwordlTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10.0
        textField.placeholder = "       Password"
        return textField
    }()
    
    //MARK: -viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.6941176471, green: 1, blue: 0.9921568627, alpha: 1)
        self.navigationItem.title = "SIGN UP"
        emailTextField.delegate = self
        fullNameTextField.delegate = self
        userNamelTextField.delegate = self
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
        view.addSubview(createAccountButton)
        view.addSubview(profileImageView)
        view.addSubview(emailTextField)
        view.addSubview(passwordlTextField)
        view.addSubview(userNamelTextField)
        view.addSubview(fullNameTextField)
        view.addSubview(addProfileImageButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // profileImageView
        profileImageView.frame.size.width = 120
        profileImageView.frame.size.height = 120
        profileImageView.frame.origin.x = self.view.frame.size.width / 2 - profileImageView.frame.size.width / 2
        profileImageView.frame.origin.y = view.safeAreaInsets.top
        
        // profileImageButton
        addProfileImageButton.frame.size.width = 300
        addProfileImageButton.frame.size.height = 30
        addProfileImageButton.frame.origin.x = self.view.frame.size.width / 2 - addProfileImageButton.frame.size.width / 2
        addProfileImageButton.frame.origin.y = view.safeAreaInsets.top+115
        
        // emailTextField
        emailTextField.frame.size.width = 300
        emailTextField.frame.size.height = 35
        emailTextField.frame.origin.x = self.view.frame.size.width / 2 - emailTextField.frame.size.width / 2
        emailTextField.frame.origin.y = view.safeAreaInsets.top + 200
        
        //fullNameTextField
        fullNameTextField.frame.size.width = 300
        fullNameTextField.frame.size.height = 35
        fullNameTextField.frame.origin.x = self.view.frame.size.width / 2 - fullNameTextField.frame.size.width / 2
        fullNameTextField.frame.origin.y = emailTextField.frame.origin.y + 50
        
        // userNamelTextField
        userNamelTextField.frame.size.width = 300
        userNamelTextField.frame.size.height = 35
        userNamelTextField.frame.origin.x = self.view.frame.size.width / 2 - userNamelTextField.frame.size.width / 2
        userNamelTextField.frame.origin.y = emailTextField.frame.origin.y + 100
        
        //passwordTextField
        passwordlTextField.frame.size.width = 300
        passwordlTextField.frame.size.height = 35
        passwordlTextField.frame.origin.x = self.view.frame.size.width / 2 - passwordlTextField.frame.size.width / 2
        passwordlTextField.frame.origin.y = emailTextField.frame.origin.y + 150
        
        // loginButton
        createAccountButton.frame.size.width = 300
        createAccountButton.frame.size.height = 70
        createAccountButton.frame.origin.x = self.view.frame.size.width / 2 - createAccountButton.frame.size.width / 2
        createAccountButton.frame.origin.y = passwordlTextField.frame.origin.y + 100
    }
    
    @objc func signUpButtonPressed() {
        let signUpManager = FirebaseAuthManager()
        if let email = emailTextField.text, let password = passwordlTextField.text, let fullName = fullNameTextField.text, let username = userNamelTextField.text, let image = profileImageView.image {
            signUpManager.createUser(
                email: email,
                fullName: fullName,
                username: username,
                password: password,
                image: image
            )
            {[weak self] (success) in
                guard let `self` = self else { return }
                var message: String = ""
                if (success) {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let TabBarController = storyboard.instantiateViewController(identifier: "onboardingVC")
                    TabBarController.modalPresentationStyle = .fullScreen
                    self.present(TabBarController, animated: true, completion: nil)
                } else {
                    message = "There was an error."
                    let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alertController, animated: true)
                }
            }
        }
    }
    
    @objc func didTapAddProfileImageButton() {
        
        let accessPhotoManager = AccessPhotoManager()
        accessPhotoManager.checkPermission()
        
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
        self.present(picker, animated: true)
    }
}

//MARK: -UIImagePickerControllerDelegate

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            addProfileImageButton.imageView?.image = UIImage(named: "")
            profileImageView.image = selectedImage
        }
        self.dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
