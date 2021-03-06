//
//  AddFriendViewController.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/11.
//

import UIKit
import Kingfisher

class AddFriendViewController: UIViewController {
    
    var user: User?
    
    private let profileImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 80
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "遠藤さくら")
        return imageView
    }()
    
    private let fullNameLabel: UILabel = {
       let label = UILabel()
        label.text = "Sakura Endo"
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        return label
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
         button.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.5725490196, blue: 0.7450980392, alpha: 1)
         button.layer.cornerRadius = 10.0
         button.setTitleColor(UIColor.white,for: .normal)
         button.setTitle("ADD", for: .normal)
         button.titleLabel?.font = UIFont.systemFont(
             ofSize: 30,
             weight: .bold
         )
         button.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
         return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Add Friend"
        view.backgroundColor = .systemBackground
        addSubviews()
        
        // set User
        // userがいる場合
        guard let _user = user else { return }
        let url = URL(string: _user.profileImageURL)
        profileImageView.kf.setImage(with: url)
        
        fullNameLabel.text = _user.fullName
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // profileImageView
        profileImageView.frame.size.width = 160
        profileImageView.frame.size.height = 160
        profileImageView.frame.origin.x = self.view.frame.size.width / 2 - profileImageView.frame.size.width / 2
        profileImageView.frame.origin.y = 200
        
        // fullNameLabel
        fullNameLabel.frame.size.width = 300
        fullNameLabel.frame.size.height = 100
        fullNameLabel.frame.origin.x = self.view.frame.size.width / 2 - fullNameLabel.frame.size.width / 2
        fullNameLabel.frame.origin.y = profileImageView.frame.origin.y + 160
        
        // addButton
        addButton.frame.size.width = 100
        addButton.frame.size.height = 80
        addButton.frame.origin.x = self.view.frame.size.width / 2 - addButton.frame.size.width / 2
        addButton.frame.origin.y = fullNameLabel.frame.origin.y + 150
        
        
    }
    
    private func addSubviews() {
        view.addSubview(profileImageView)
        view.addSubview(fullNameLabel)
        view.addSubview(addButton)
    }
    
    @objc func addButtonPressed() {
        
        guard let _user = user else { return }
        UserService.follow(uid: _user.uid) { _ in
            let alert = UIAlertController(title: nil, message: "Successfully added \(_user.fullName) as a friend" , preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK ! ! !" , style: .default) { action in
                self.navigationController?.popToRootViewController(animated: true)
            }
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)
        }
    }

}
