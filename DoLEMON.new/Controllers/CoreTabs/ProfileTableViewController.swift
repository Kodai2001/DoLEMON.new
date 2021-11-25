//
//  ProfileTableViewController.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/14.
//

import UIKit


class ProfileViewController: UIViewController {
    
    var profileCustomHeaderView = ProfileCustomHeaderView()
    
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isUserInteractionEnabled = true
        view.backgroundColor = #colorLiteral(red: 0.6941176471, green: 1, blue: 0.9921568627, alpha: 1) 
        
        // title
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Profile" 
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // HeaderView
        tableView.register(ProfileCustomHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: "ProfileCustomHeaderView")
        
        // tableViewCell
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "ProfileTableViewCell")
        
        tableView.tableFooterView = UIView(frame: .zero)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
}


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            let vc = SearchFriendViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 1 {
            // sign out
            
            // UIAlertControllerの生成
            let alert = UIAlertController(title: nil, message: "Are you sure to sign out?", preferredStyle: .alert)
            
            // sign out
            let signoutAction = UIAlertAction(title: "sign out", style: .destructive) { action in
                let authManager = FirebaseAuthManager()
                authManager.signout()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let homeVC = storyboard.instantiateViewController(identifier: "homeVC")
                homeVC.modalPresentationStyle = .fullScreen
                self.present(homeVC, animated: true, completion: nil)
                
            }
            
            // cancel
            let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
            
            alert.addAction(signoutAction)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true, completion: nil)
        }
        
        if indexPath.row == 2 {
            guard let uid = FirebaseAuthManager.shared.userSession?.uid else { return }
            
            let alert = UIAlertController(title: nil, message: uid, preferredStyle: .alert)
            
            // copy
            let signoutAction = UIAlertAction(title: "Copy", style: .default) { action in
                // alert.messageをコピーする
                UIPasteboard.general.string = alert.message ?? ""
            }
            
            // cancel
            let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
            
            alert.addAction(signoutAction)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell",
                                                 for: indexPath) as! ProfileTableViewCell
        if indexPath.row == 0 {
            cell.configureCell(label: "Add friend", icon: UIImage(systemName: "person.fill.badge.plus")!)
        }
        else if indexPath.row == 1 {
            cell.configureCell(label: "Sign out", icon: (UIImage(systemName: "rectangle.portrait.and.arrow.right.fill") ?? UIImage(named: "Logout"))!)
        }
        // headerが反応しないため臨時で設置
        else if indexPath.row == 2 {
            cell.configureCell(label: "Show User ID", icon: UIImage(systemName: "key.fill")!)
        }
        return cell
    }
    
    
    // Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(
            withIdentifier:"ProfileCustomHeaderView") as! ProfileCustomHeaderView
        view.followingNumberButton.addTarget(self, action: #selector(didTapFollowingNumButton), for: .touchUpInside)
        view.followersNumberButton.addTarget(self, action: #selector(didTapFollowersNumButton), for: .touchUpInside)
        view.editProfileButton.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 250
    }
    
    @objc func didTapFollowingNumButton() {
        let vc = FollowingListTableViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapFollowersNumButton() {
        let vc = FollowersListTableViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapEditProfileButton() {
        let vc = EditProfileTableViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


