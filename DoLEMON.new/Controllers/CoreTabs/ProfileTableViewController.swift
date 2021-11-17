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
        
        view.backgroundColor = #colorLiteral(red: 0.6941176471, green: 1, blue: 0.9921568627, alpha: 1)
        
        // title
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Profile"
        
        tableView.delegate = self
        tableView.dataSource = self
        profileCustomHeaderView.delegate = self
        // HeaderView
        tableView.register(ProfileCustomHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: "ProfileCustomHeaderView")
        
        // tableViewCell
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "ProfileTableViewCell")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = SearchFriendViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell",
                                                 for: indexPath) as! ProfileTableViewCell
        return cell
    }
    
    
    // Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(
            withIdentifier:"ProfileCustomHeaderView") as! ProfileCustomHeaderView
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 250
    }
    
}

extension ProfileViewController: ProfileCustomHeaderViewDelegate {
    func editProfileButtonPressed() {
        print("Succesfully pressed")
    }
}

