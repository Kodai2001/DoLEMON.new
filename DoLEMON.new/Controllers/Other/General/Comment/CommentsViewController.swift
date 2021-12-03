//
//  CommentsViewController.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/13.
//

import UIKit
import FirebaseFirestore



class CommentsViewController: UIViewController {
    
    var pin = Pin()
    var comment = Comment()
    
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
        label.textColor = .label
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
        label.textColor = .label
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
        label.textColor = .label
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
        textView.textColor = .label
        textView.backgroundColor = .secondarySystemFill
        textView.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return textView
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.5725490196, blue: 0.7450980392, alpha: 1)
        button.layer.cornerRadius = 30
        button.clipsToBounds = true
        button.setTitleColor(UIColor.white,for: .normal)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: 50,
            weight: .bold
        )
        button.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        textView.delegate = self
        view.backgroundColor = .systemBackground
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
                self.view.frame.origin.y -= keyboardSize.height
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
        view.addSubview(placeNameIcon)
        view.addSubview(placeNameLabel)
        view.addSubview(addressIcon)
        view.addSubview(addressLabel)
        view.addSubview(usernameIcon)
        view.addSubview(usernameLabel)
        view.addSubview(textViewIcon)
        view.addSubview(textView)
        view.addSubview(addButton)
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
        textView.frame.size.height = 200
        textView.frame.origin.x = placeNameIcon.frame.origin.x+60
        textView.frame.origin.y = view.safeAreaInsets.top + 350
        
        // addButton
        addButton.frame.size.width = 60
        addButton.frame.size.height = 60
        addButton.frame.origin.x = view.frame.size.width-70
        addButton.frame.origin.y = textView.frame.origin.y + 160
    }
    
    @objc func didTapAddButton() {
        self.dismiss(animated: true, completion: nil)
        putDataIntoCommentStruct()
        
        pin.uid = FirebaseAuthManager.shared.userSession?.uid ?? ""
        FirestoreManager.shared.savePin(pin: pin)
    }
    
    func putDataIntoCommentStruct () {
        pin.commentText = self.textView.text ?? ""
        pin.addressName = self.addressLabel.text ?? ""
    }
}

extension CommentsViewController: UITextViewDelegate {
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
