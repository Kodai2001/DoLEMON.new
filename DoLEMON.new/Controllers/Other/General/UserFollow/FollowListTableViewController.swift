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
    
    var followUnfollowManager: FollowUnfollowManager?
    var isFollowed: Bool {return followUnfollowManager?.user.isFollowed ?? false}

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // title
        navigationController?.navigationBar.prefersLargeTitles = false
        firestoreManager.fetchUser { user in
            self.navigationItem.title = user.username
        }
        
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
        // cellにUserを反映させる
        let user = self.users[indexPath.row]

        cell.accountNameLabel.text = user.username
        cell.fullNameLabel.text = user.fullName

        let url = URL(string: user.profileImageURL)
        cell.profileImageView.kf.setImage(with: url)
        
//        cell.followFollowingButton.backgroundColor = isFollowed ? .white : .systemBlue
//        cell.followFollowingButton.setTitle(isFollowed ? "Following" : "Follow", for: .normal)
//        cell.followFollowingButton.setTitleColor(isFollowed ? .black : .white, for: .normal)
//        cell.followFollowingButton.layer.borderWidth = isFollowed ? 2.0 : 0.0
//
//        cell.followFollowingButton.addTarget(self, action: #selector(didTapFollowUnfollowButton), for: .touchUpInside)
//
//        cell.followFollowingButton.tag = indexPath.row
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//    @objc func didTapFollowUnfollowButton(_ sender: UIButton) {
//        
//        var user = self.users[sender.tag]
//        let followUnfollowManager = FollowUnfollowManager(user: user)
//        
//        print("DEBUG: user.isFollowed is \(self.isFollowed)")
//        
//        user.isFollowed ?? false ? followUnfollowManager.unfollow(completion: {
//            sender.backgroundColor = .systemBlue
//            sender.setTitle("Follow", for: .normal)
//            sender.setTitleColor(.white, for: .normal)
//            sender.layer.borderWidth = 0.0
//        })
//        : followUnfollowManager.follow(completion: {
//            sender.backgroundColor = .white
//            sender.setTitle("Following", for: .normal)
//            sender.setTitleColor(.black, for: .normal)
//            sender.layer.borderWidth = 2.0
//            print("DEBUG: user.isFollowed is \(self.isFollowed)")
//        })
//        
//    }
}
