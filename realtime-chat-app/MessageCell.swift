//
//  MessageCell.swift
//  realtime-chat-app
//
//  Created by Tsang Ka Kui on 26/8/2016.
//  Copyright © 2016年 Tsang Ka Kui. All rights reserved.
//

import UIKit
import Firebase

// let messageCache = NSCache<AnyObject, AnyObject>()
// let userCache = NSCache<AnyObject, AnyObject>()

class MessageCell: UITableViewCell {
    
    var message: Message? {
        didSet {
            self.configureCell()
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 32
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "12:10 AM"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupViews() {
        self.addSubview(profileImageView)
        profileImageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        self.addSubview(timeLabel)
        timeLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor).isActive = true
        timeLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 88, y: textLabel!.frame.origin.y, width: textLabel!.frame.width, height: textLabel!.frame.height)
        
        detailTextLabel?.frame = CGRect(x: 88, y: detailTextLabel!.frame.origin.y, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
    }
    
    func configureCell() {
        
        self.setTimeLabel()
        
        self.detailTextLabel?.text = self.message?.text
        
        if let uid = message?.getChartUserId() {
            
            let ref = FIRDatabase.database().reference().child("users").child(uid)
            
            ref.observeSingleEvent(of: .value, with: {(snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    
                    if let name = dictionary["name"] as? String {
                         self.textLabel?.text = name
                    }
                    
                    if let urlString = dictionary["imageUrl"] as? String {
                        self.profileImageView.fetchImage(urlString: urlString)
                    }
  
                }
                
            })
        }
    }
    
    func setTimeLabel() {
        if let seconds = self.message?.timestamp?.doubleValue {
            let timestamp = Date(timeIntervalSince1970: seconds)
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm a"
            timeLabel.text = formatter.string(from: timestamp)
        }
    }
}
