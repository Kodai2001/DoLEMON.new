//
//  EditProfileTableViewController.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/24.
//

import UIKit
import Kingfisher

class EditProfileTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: .zero)
        
        // HeaderView
        tableView.register(EditProfileCustomHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: "EditProfileCustomHeaderView")
        
        // tableViewCell
        tableView.register(EditProfileTableViewCell.self, forCellReuseIdentifier: "EditProfileTableViewCell")
        
        configureBarButtonItem()
    }
    
    func configureBarButtonItem() {
        
        navigationItem.title = "Edit Profile"
        
        var cancelBarButtonItem: UIBarButtonItem!
        var doneBarButtonItem: UIBarButtonItem!
        
        cancelBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelBarButtonTapped(_:)))
        doneBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneBarButtonTapped(_:)))
        
        self.navigationItem.rightBarButtonItem = doneBarButtonItem
        self.navigationItem.leftBarButtonItem = cancelBarButtonItem
    }
    
    // "Cancel"ボタンが押された時の処理
    @objc func cancelBarButtonTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    // "Done"ボタンが押された時の処理
    @objc func doneBarButtonTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditProfileTableViewCell", for: indexPath) as! EditProfileTableViewCell
        FirestoreManager.shared.fetchCurrentUser { user in
            if indexPath.row == 0 {
                cell.configureCell(label: "FullName", text: user.fullName)
            }
            else if indexPath.row == 1 {
                cell.configureCell(label: "Username", text: user.username)
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = ChangeFullNameTableViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 1 {
            let vc = ChangeUsernameTableViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(
            withIdentifier:"EditProfileCustomHeaderView") as! EditProfileCustomHeaderView
        
        FirestoreManager.shared.fetchCurrentUser { user in
            let url = URL(string: user.profileImageURL)
            view.profileImageView.kf.setImage(with: url)
        }
        
        view.changeButton.addTarget(self, action: #selector(didTapChangeProfileButton), for: .touchUpInside)
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 250
    }
    
    @objc func didTapChangeProfileButton() {
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

extension EditProfileTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let view = tableView.dequeueReusableHeaderFooterView(
            withIdentifier:"EditProfileCustomHeaderView") as! EditProfileCustomHeaderView
        if let selectedImage = info[.originalImage] as? UIImage {
            view.profileImageView.image = selectedImage
            FirestoreManager.shared.updateProfileImage(image: selectedImage)
        }
        self.dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
}

