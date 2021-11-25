//
//  FollowersListTableViewController.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/25.
//

import UIKit

class FollowersListTableViewController: UITableViewController {
    
    let firestoreManager = FirestoreManager()
    var followers: [User] = []
    
    var followUnfollowManager: FollowUnfollowManager?
    var isFollowed: Bool {return followUnfollowManager?.user.isFollowed ?? false}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // title
        navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "Followers"
        
        tableView.register(UserFollowTableViewCell.self, forCellReuseIdentifier: "UserFollowTableViewCell")
        
        // firestoreからデータを取得する
        firestoreManager.fetchFollowers { uids in
            self.firestoreManager.fetchUsers(uids: uids) { users in
                self.followers = users
                self.tableView.reloadData()
            }
        }
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.followers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserFollowTableViewCell",
                                                 for: indexPath) as! UserFollowTableViewCell
        // cellにUserを反映させる
        let user = self.followers[indexPath.row]
        
        cell.accountNameLabel.text = user.username
        cell.fullNameLabel.text = user.fullName
        
        let url = URL(string: user.profileImageURL)
        cell.profileImageView.kf.setImage(with: url)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
