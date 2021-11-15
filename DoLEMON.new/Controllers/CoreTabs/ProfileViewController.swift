//
//  ProfileViewController.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/14.
//

import UIKit

class ProfileViewController: UITableViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
        }
        
        
        
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 3
        }
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            return 3
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "cell"
            return cell
            
        }
    }
