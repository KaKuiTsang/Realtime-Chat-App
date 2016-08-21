//
//  LoginForm.swift
//  realtime-chat-app
//
//  Created by Tsang Ka Kui on 21/8/2016.
//  Copyright © 2016年 Tsang Ka Kui. All rights reserved.
//

import UIKit

class LoginForm: Form {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var emailTextField: TextField = {
        let tf = TextField()
        tf.placeholder = "Email"
        return tf
    }()
    
    var passwordTextField: TextField = {
        let tf = TextField()
        tf.placeholder = "Password"
        tf.clearsOnInsertion = false
        tf.isSecureTextEntry = true
        return tf
    }()
    
    func setupSubViews() {
        self.addSubview(emailTextField)
        emailTextField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3).isActive = true
        
        self.addSubview(passwordTextField)
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3).isActive = true
    }
}
