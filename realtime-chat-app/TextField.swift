//
//  TextField.swift
//  realtime-chat-app
//
//  Created by Tsang Ka Kui on 21/8/2016.
//  Copyright © 2016年 Tsang Ka Kui. All rights reserved.
//

import UIKit

class TextField: UITextField {
    
    let bottomBorder = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        let padding = UIView(frame:CGRect(x: 0, y: 0, width: 15, height: 30))
        self.leftView = padding
        self.leftViewMode = UITextFieldViewMode.always
        self.autocapitalizationType = .none
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setupBottomBorder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBottomBorder() {
        self.addSubview(bottomBorder)
        bottomBorder.backgroundColor = UIColor(130,130,130)
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bottomBorder.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        bottomBorder.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        bottomBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

}
