//
//  ViewController.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/11.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let logoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    private let subTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "WITH FRIENDS,\nWITH NO STRESS"
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
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
    
    private let signUpButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .clear
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 30
        button.setTitleColor(UIColor.black,for: .normal)
        button.layer.borderWidth = 2.0
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle("SIGN UP", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: 30,
            weight: .bold
        )
        button.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.937254902, blue: 0.4705882353, alpha: 1)
        addSubviews()
        
        // title
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true

    }
    
    
    
    private func addSubviews() {
        view.addSubview(logoImageView)
        view.addSubview(subTitleLabel)
        view.addSubview(loginButton)
        view.addSubview(signUpButton)
    }
    
    override func viewDidLayoutSubviews() {
        
        // logoImageView
        logoImageView.frame.size.width = 300
        logoImageView.frame.size.height = 300
        logoImageView.frame.origin.x = self.view.frame.size.width / 2 - logoImageView.frame.size.width / 2
        logoImageView.frame.origin.y = self.view.frame.size.height / 5 - logoImageView.frame.size.height / 2
        
        // subTitleLabel
        subTitleLabel.frame.size.width = 400
        subTitleLabel.frame.size.height = 100
        subTitleLabel.frame.origin.x = self.view.frame.size.width / 2 - subTitleLabel.frame.size.width / 2
        subTitleLabel.frame.origin.y = self.view.frame.size.height / 5 - logoImageView.frame.size.height / 2 + 300
        
        // loginButton
        loginButton.frame.size.width = 300
        loginButton.frame.size.height = 70
        loginButton.frame.origin.x = self.view.frame.size.width / 2 - loginButton.frame.size.width / 2
        loginButton.frame.origin.y = self.view.frame.size.height / 5 - logoImageView.frame.size.height / 2 + 450
        
        // signUpButton
        signUpButton.frame.size.width = 300
        signUpButton.frame.size.height = 70
        signUpButton.frame.origin.x = self.view.frame.size.width / 2 - signUpButton.frame.size.width / 2
        signUpButton.frame.origin.y = self.view.frame.size.height / 5 - logoImageView.frame.size.height / 2 + 570
    }
    
    @objc func loginButtonPressed() {
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func signUpButtonPressed() {
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    


}

