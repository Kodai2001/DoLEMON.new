//
//  SearchFriendViewController.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/11.
//

import UIKit

class SearchFriendViewController: UIViewController {
    
    var addBtn: UIButton = {
       let button = UIButton()
        button.addTarget(self, action: #selector(onTappedPush), for: .touchUpInside)
        button.backgroundColor = .systemBlue
        return button
    }()

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .yellow
            view.addSubview(addBtn)
            addBtn.frame = CGRect(x: 100, y: 500, width: 100, height: 100)
            
            // titleの設定
            navigationItem.title = "ADD FRIEND"
            navigationItem.largeTitleDisplayMode = .always
            navigationController?.navigationBar.prefersLargeTitles = true

        }
    
    @objc func onTappedPush() {
        let vc = AddFriendViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
