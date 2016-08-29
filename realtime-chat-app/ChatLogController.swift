//
//  ChatLogController.swift
//  realtime-chat-app
//
//  Created by Tsang Ka Kui on 26/8/2016.
//  Copyright © 2016年 Tsang Ka Kui. All rights reserved.
//

import UIKit
import Firebase

class ChatLogController: UICollectionViewController, UITextFieldDelegate {

    var receiver: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.alwaysBounceVertical =  true
        self.collectionView?.backgroundColor = UIColor.white
        self.setupInputContainer()
        self.setupSendButton()
        self.setupTextField()
    }
    
    var topBorder: UIView = {
        let border = UIView()
        border.backgroundColor = UIColor.darkGray
        border.translatesAutoresizingMaskIntoConstraints = false
        return border
    }()
    
    var inputContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(sendButtonDidPress), for: .touchUpInside)
        return button
    }()
    
    lazy var textField: UITextField = {
        let tf = UITextField()
        tf.delegate = self
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendButtonDidPress()
        return true
    }
    
    func setupInputContainer() {
        view.addSubview(inputContainer)
        inputContainer.addSubview(topBorder)
        
        inputContainer.heightAnchor.constraint(equalToConstant: 60).isActive = true
        inputContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        inputContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        inputContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        topBorder.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        topBorder.heightAnchor.constraint(equalToConstant: 1/UIScreen.main.scale).isActive = true
        topBorder.topAnchor.constraint(equalTo: inputContainer.topAnchor).isActive = true
        topBorder.leadingAnchor.constraint(equalTo: inputContainer.leadingAnchor).isActive = true
    }
    
    func setupSendButton() {
        inputContainer.addSubview(sendButton)
        sendButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        sendButton.topAnchor.constraint(equalTo: inputContainer.topAnchor).isActive = true
        sendButton.bottomAnchor.constraint(equalTo: inputContainer.bottomAnchor).isActive = true
        sendButton.trailingAnchor.constraint(equalTo: inputContainer.trailingAnchor).isActive = true
    }
    
    func setupTextField() {
        inputContainer.addSubview(textField)
        textField.topAnchor.constraint(equalTo: inputContainer.topAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: inputContainer.bottomAnchor).isActive = true
        textField.leadingAnchor.constraint(equalTo: inputContainer.leadingAnchor, constant: 12).isActive = true
        textField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor).isActive = true
    }
    
    func sendButtonDidPress() {
        
        if let text = textField.text, text != "" {
            let sender = FIRAuth.auth()!.currentUser!.uid
            let receiver = self.receiver!.uid!
            let ref = FIRDatabase.database().reference().child("messages").childByAutoId()
            let timestamp = Int(NSDate().timeIntervalSince1970)
            let values:[String: Any] = ["from": sender, "to": receiver, "text": text, "timestamp": timestamp]
            ref.updateChildValues(values)
            textField.text = ""
        }
    }

}
