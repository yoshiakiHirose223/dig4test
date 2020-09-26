//
//  UsersCell.swift
//  dig4
//
//  Created by 廣瀬由明 on 2019/11/15.
//  Copyright © 2019 廣瀬由明. All rights reserved.
//

import UIKit

class UsersCell: UITableViewCell {
    var userImageView: UIImageView!
    var userNameLabel: UILabel!


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        viewInit()
    }
    
    override func layoutSubviews() {
        viewLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func viewLayout () {
        let myView = self.bounds
        
        let userImageViewWidth = myView.height
        let userImageViewHeight = myView.height
        
        let userNameLabelWidth = myView.width - userImageViewWidth
        let userNameLabelHeight = myView.height * 0.5
        
        userImageView.widthAnchor.constraint(equalToConstant: userImageViewWidth).isActive = true
        userImageView.heightAnchor.constraint(equalToConstant: userImageViewHeight).isActive = true
        userImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        userImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
        userNameLabel.widthAnchor.constraint(equalToConstant: userNameLabelWidth).isActive = true
        userNameLabel.heightAnchor.constraint(equalToConstant: userNameLabelHeight).isActive = true
        userNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        userNameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor).isActive = true

    }
    
    func viewInit () {
        userImageView = UIImageView()
        userNameLabel = UILabel()
        
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(userImageView)
        self.addSubview(userNameLabel)
    }

}
