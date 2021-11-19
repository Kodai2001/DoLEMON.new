//
//  DemoTableViewController.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/19.
//

import UIKit

class DemoTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // title
        navigationItem.title = "Account Name"
        
        tableView.register(UserFollowTableViewCell.self, forCellReuseIdentifier: "UserFollowTableViewCell")
    }
    
  

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 30
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserFollowTableViewCell",
                                                 for: indexPath) as! UserFollowTableViewCell
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
