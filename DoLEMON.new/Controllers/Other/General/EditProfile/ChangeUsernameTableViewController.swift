//
//  ChangeUsernameTableViewController.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/18.
//

import UIKit

class ChangeUsernameTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBarButtonItem()
        
        // tableViewCell
        tableView.register(RenameTableViewCell.self, forCellReuseIdentifier: "RenameTableViewCell")
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    func configureBarButtonItem() {
        
        navigationItem.title = "Username"
        
        var doneBarButtonItem: UIBarButtonItem!
        
        doneBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneBarButtonTapped(_:)))
        
        self.navigationItem.rightBarButtonItem = doneBarButtonItem
    }
    
    // "Done"ボタンが押された時の処理
    @objc func doneBarButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RenameTableViewCell",
                                                 for: indexPath) as! RenameTableViewCell
        FirestoreManager.shared.fetchCurrentUser { user in
            cell.configureCell(titleLabel: "Username", nameTextField: user.username)
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

