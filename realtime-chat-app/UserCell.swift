//
//  UserCell.swift
//  realtime-chat-app
//
//  Created by Tsang Ka Kui on 22/8/2016.
//  Copyright © 2016年 Tsang Ka Kui. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "chat.png")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 32
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func setupViews() {
        self.addSubview(profileImageView)
        profileImageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 88, y: textLabel!.frame.origin.y, width: textLabel!.frame.width, height: textLabel!.frame.height)
        
        detailTextLabel?.frame = CGRect(x: 88, y: detailTextLabel!.frame.origin.y, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
    }

}
