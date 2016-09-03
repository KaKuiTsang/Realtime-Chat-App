//
//  ChatBubbleCell.swift
//  realtime-chat-app
//
//  Created by Tsang Ka Kui on 31/8/2016.
//  Copyright © 2016年 Tsang Ka Kui. All rights reserved.
//

import UIKit

class ChatBubbleCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.backgroundColor = UIColor.clear
        tv.textColor = UIColor.white
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    var chatBubble: UIView = {
        let view = UIView()
        //view.backgroundColor = UIColor(0, 137, 249)
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var messsageImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var chatBubbleWidthConstraint: NSLayoutConstraint?
    var chatBubbleLeadingConstraint: NSLayoutConstraint?
    var chatBubbleTrailingConstraint: NSLayoutConstraint?
    
    func setupViews() {
        self.addSubview(profileImageView)
        profileImageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.addSubview(chatBubble)
        chatBubbleWidthConstraint = chatBubble.widthAnchor.constraint(equalToConstant: self.frame.width/2)
        chatBubbleWidthConstraint?.isActive = true
        chatBubble.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        chatBubble.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        chatBubbleTrailingConstraint = chatBubble.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        chatBubbleTrailingConstraint?.isActive = true
        chatBubbleLeadingConstraint = chatBubble.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8)
        
        chatBubble.addSubview(textView)
        textView.topAnchor.constraint(equalTo: chatBubble.topAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: chatBubble.bottomAnchor).isActive = true
        textView.leadingAnchor.constraint(equalTo: chatBubble.leadingAnchor, constant: 8).isActive = true
        textView.trailingAnchor.constraint(equalTo: chatBubble.trailingAnchor, constant: -8).isActive = true
        
        chatBubble.addSubview(messsageImageView)
        messsageImageView.topAnchor.constraint(equalTo: chatBubble.topAnchor).isActive = true
        messsageImageView.bottomAnchor.constraint(equalTo: chatBubble.bottomAnchor).isActive = true
        messsageImageView.leadingAnchor.constraint(equalTo: chatBubble.leadingAnchor).isActive = true
        messsageImageView.trailingAnchor.constraint(equalTo: chatBubble.trailingAnchor).isActive = true
    }
}
