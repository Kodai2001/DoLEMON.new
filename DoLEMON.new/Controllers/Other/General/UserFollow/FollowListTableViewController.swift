//
//  DemoTableViewController.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/19.
//

import UIKit

class FollowListTableViewController: UITableViewController {
    
    let firestoreManager = FirestoreManager()
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // title
        navigationItem.title = "Account Name"
        
        tableView.register(UserFollowTableViewCell.self, forCellReuseIdentifier: "UserFollowTableViewCell")
        firestoreManager.fetchUsers { [self] _users in
            users = _users
            tableView.tableFooterView = UIView(frame: .zero)
            tableView.reloadData()
        }
    }
    
   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserFollowTableViewCell",
                                                 for: indexPath) as! UserFollowTableViewCell
        let user = self.users[indexPath.row]

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
