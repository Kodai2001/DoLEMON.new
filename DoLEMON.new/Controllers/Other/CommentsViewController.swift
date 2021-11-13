//
//  CommentsViewController.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/13.
//

import UIKit

class CommentsViewController: UIViewController {
    
    private let placeNameIcon: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    private let placeNameLabel: UILabel = {
       let label = UILabel()
        label.text = "WITH FRIENDS,\nWITH NO STRESS"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private let addressIcon: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    private let addressLabel: UILabel = {
       let label = UILabel()
        label.text = "WITH FRIENDS,\nWITH NO STRESS"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private let usernameIcon: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
       let label = UILabel()
        label.text = "WITH FRIENDS,\nWITH NO STRESS"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        view.backgroundColor = .systemBackground
       
    }
    
    private func addSubviews() {
        view.addSubview(placeNameIcon)
        view.addSubview(placeNameLabel)
        view.addSubview(addressIcon)
        view.addSubview(addressLabel)
        view.addSubview(usernameIcon)
        view.addSubview(usernameLabel)
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    


}
