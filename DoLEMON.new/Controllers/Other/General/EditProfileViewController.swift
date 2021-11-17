//
//  EditProfileViewController.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/14.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // HeaderView
        tableView.register(EditProfileCustomHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: "EditProfileCustomHeaderView")
        
        // tableViewCell
        tableView.register(EditProfileTableViewCell.self, forCellReuseIdentifier: "EditProfileTableViewCell")
        
        configureBarButtonItem()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
        print("did tap cancelBarButtonItem")
    }
    // "Done"ボタンが押された時の処理
    @objc func doneBarButtonTapped(_ sender: UIBarButtonItem) {
        print("did tap doneBarButtonItem")
    }
    
    
}

extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditProfileTableViewCell", for: indexPath) as! EditProfileTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(
            withIdentifier:"EditProfileCustomHeaderView") as! EditProfileCustomHeaderView
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 250
    }
}
