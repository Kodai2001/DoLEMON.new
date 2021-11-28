//
//  ShowCommentsViewController.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/28.
//

import UIKit

class ShowCommentsViewController: UIViewController {
    
    private let placeNameIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "map")
        return imageView
    }()
    
    var placeNameLabel: UILabel = {
        let label = UILabel()
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
        imageView.image = UIImage(systemName: "mappin")
        return imageView
    }()
    
    var addressLabel: UILabel = {
        let label = UILabel()
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
        imageView.image = UIImage(systemName: "person")
        return imageView
    }()
    
     let usernameLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private let textViewIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "note.text")
        return imageView
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.textColor = .black
        textView.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        view.backgroundColor = #colorLiteral(red: 0.6941176471, green: 1, blue: 0.9921568627, alpha: 1)
    }
    
    private func addSubviews() {
        view.addSubview(placeNameIcon)
        view.addSubview(placeNameLabel)
        view.addSubview(addressIcon)
        view.addSubview(addressLabel)
        view.addSubview(usernameIcon)
        view.addSubview(usernameLabel)
        view.addSubview(textViewIcon)
        view.addSubview(textView)
    }
    
    override func viewDidLayoutSubviews() {
        // placeNameIcon
        placeNameIcon.frame.size.width = 40
        placeNameIcon.frame.size.height = 40
        placeNameIcon.frame.origin.x = 25
        placeNameIcon.frame.origin.y = view.safeAreaInsets.top + 50
        
        // placeNameLabel
        placeNameLabel.frame.size.width = view.frame.size.width-100
        placeNameLabel.frame.size.height = 50
        placeNameLabel.frame.origin.x = placeNameIcon.frame.origin.x+60
        placeNameLabel.frame.origin.y = view.safeAreaInsets.top + 40
        
        // addressIcon
        addressIcon.frame.size.width = 40
        addressIcon.frame.size.height = 50
        addressIcon.frame.origin.x = 25
        addressIcon.frame.origin.y = view.safeAreaInsets.top + 150
        
        // addressLabel
        addressLabel.frame.size.width = view.frame.size.width-100
        addressLabel.frame.size.height = 40
        addressLabel.frame.origin.x = placeNameIcon.frame.origin.x+60
        addressLabel.frame.origin.y = view.safeAreaInsets.top + 150
        
        // usernameIcon
        usernameIcon.frame.size.width = 40
        usernameIcon.frame.size.height = 40
        usernameIcon.frame.origin.x = 25
        usernameIcon.frame.origin.y = view.safeAreaInsets.top + 250
        
        // usernameLabel
        usernameLabel.frame.size.width = view.frame.size.width-100
        usernameLabel.frame.size.height = 40
        usernameLabel.frame.origin.x = placeNameIcon.frame.origin.x+60
        usernameLabel.frame.origin.y = view.safeAreaInsets.top + 250
        
        // textViewIcon
        textViewIcon.frame.size.width = 40
        textViewIcon.frame.size.height = 40
        textViewIcon.frame.origin.x = 25
        textViewIcon.frame.origin.y = view.safeAreaInsets.top + 350
        
        // textView
        textView.frame.size.width = view.frame.size.width-100
        textView.frame.size.height = 300
        textView.frame.origin.x = placeNameIcon.frame.origin.x+60
        textView.frame.origin.y = view.safeAreaInsets.top + 350
        
    }

}
