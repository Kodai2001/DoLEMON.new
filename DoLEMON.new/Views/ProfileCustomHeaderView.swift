//
//  ProfileCustomHeaderView.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/14.
//

import UIKit

class ProfileCustomHeaderView: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?) {
          super.init(reuseIdentifier: reuseIdentifier)
        backgroundColor = .red
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
