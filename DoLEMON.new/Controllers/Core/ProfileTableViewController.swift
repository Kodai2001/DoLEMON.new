//
//  ProfileTableViewController.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/14.
//

import UIKit

//struct CustomCell {
//    let icon: UIImage
//    let title: String
//}

class ProfileViewController: UIViewController {
    
//    let customCell = CustomCell(icon: UIImage(systemName: "person.fill.badge.plus")!, title: "Add Friend")
    
    
    var profileCustomHeaderView = ProfileCustomHeaderView()
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        profileCustomHeaderView.delegate = self
        // HeaderView
        tableView.register(ProfileCustomHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: "ProfileCustomHeaderView")
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "ProfileTableViewCell")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath)
        cell.textLabel?.text = "cell"
        return cell
    }
    
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

