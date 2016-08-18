//
//  ViewController.swift
//  realtime-chat-app
//
//  Created by Tsang Ka Kui on 18/8/2016.
//  Copyright © 2016年 Tsang Ka Kui. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(61, 91, 151)
        self.setupSubviews()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "chat.png")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    var textFieldContainer: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor.white
        container.layer.cornerRadius = 5
        container.layer.masksToBounds = true
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    lazy var nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        let padding = UIView(frame:CGRect(x: 0, y: 0, width: 15, height: 30))
        tf.leftView = padding
        tf.leftViewMode = UITextFieldViewMode.always
        tf.delegate = self
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        let padding = UIView(frame:CGRect(x: 0, y: 0, width: 15, height: 30))
        tf.leftView = padding
        tf.leftViewMode = UITextFieldViewMode.always
        tf.delegate = self
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        let padding = UIView(frame:CGRect(x: 0, y: 0, width: 15, height: 30))
        tf.leftView = padding
        tf.leftViewMode = UITextFieldViewMode.always
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "password"
        tf.delegate = self
        tf.clearsOnInsertion = false
        tf.isSecureTextEntry = true
        return tf
    }()
    
    var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(0, 138, 230)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    func setupSubviews() {
        
        view.addSubview(textFieldContainer)
        textFieldContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        textFieldContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        textFieldContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textFieldContainer.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        view.addSubview(profileImageView)
        profileImageView.bottomAnchor.constraint(equalTo: textFieldContainer.topAnchor, constant: -50).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(registerButton)
        registerButton.topAnchor.constraint(equalTo: textFieldContainer.bottomAnchor, constant: 12).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        textFieldContainer.addSubview(nameTextField)
        nameTextField.topAnchor.constraint(equalTo: textFieldContainer.topAnchor).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: textFieldContainer.widthAnchor, multiplier: 1).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: textFieldContainer.heightAnchor, multiplier: 1/3).isActive = true
        
        textFieldContainer.addSubview(emailTextField)
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: textFieldContainer.widthAnchor, multiplier: 1).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: textFieldContainer.heightAnchor, multiplier: 1/3).isActive = true
        
        textFieldContainer.addSubview(passwordTextField)
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: textFieldContainer.widthAnchor, multiplier: 1).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: textFieldContainer.heightAnchor, multiplier: 1/3).isActive = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

