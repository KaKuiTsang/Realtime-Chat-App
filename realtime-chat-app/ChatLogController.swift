//
//  ChatLogController.swift
//  realtime-chat-app
//
//  Created by Tsang Ka Kui on 26/8/2016.
//  Copyright © 2016年 Tsang Ka Kui. All rights reserved.
//

import UIKit
import Firebase

class ChatLogController: UICollectionViewController, UITextFieldDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellId = "chatCell"

    var receiver: User?
    
    var messages = [Message]()
    
    var topBorder: UIView = {
        let border = UIView()
        border.backgroundColor = UIColor.darkGray
        border.translatesAutoresizingMaskIntoConstraints = false
        return border
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
    
    var inputContainerBottomConstraint: NSLayoutConstraint?
    
    lazy var inputContainer: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor.white
        container.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        container.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(self.topBorder)
        self.topBorder.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
        self.topBorder.heightAnchor.constraint(equalToConstant: 1/UIScreen.main.scale).isActive = true
        self.topBorder.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        self.topBorder.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        
        container.addSubview(self.sendButton)
        self.sendButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        self.sendButton.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        self.sendButton.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        self.sendButton.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        
        container.addSubview(self.textField)
        self.textField.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        self.textField.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        self.textField.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12).isActive = true
        self.textField.trailingAnchor.constraint(equalTo: self.sendButton.leadingAnchor).isActive = true
        
        return container
    }()
    
    override var inputAccessoryView: UIView? {
        get {
            
            return inputContainer
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.alwaysBounceVertical =  true
        self.collectionView?.backgroundColor = UIColor.white
        self.collectionView?.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        self.collectionView?.keyboardDismissMode = .interactive
        self.collectionView?.register(ChatBubbleCell.self, forCellWithReuseIdentifier: cellId)
        self.fetchMessages()
        //self.collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 58, right: 0)
        //self.setupInputContainer()
        //self.setupSendButton()
        //self.setupTextField()
        
        //self.setupKeyboardObervers()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    private func getEstimatedFrameForText(text:String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 16)]
        return NSString(string: text).boundingRect(with: size, options: options, attributes: attributes, context: nil)
    }
    
    func fetchMessages() {
        
        guard let uid = FIRAuth.auth()?.currentUser?.uid else{ return }
        
        let userMessageRef = FIRDatabase.database().reference().child("user-messages").child(uid)
        
        userMessageRef.observe(.childAdded, with: {(snapshot) in
            let messageId = snapshot.key
            let messageRef = FIRDatabase.database().reference().child("messages").child(messageId)
            messageRef.observeSingleEvent(of: .value, with: {(snapshot) in
                guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
                let message = Message()
                message.key = messageId
                message.setValuesForKeys(dictionary)
                if message.getChartUserId() == self.receiver?.uid {
                    self.messages.append(message)
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                    }
                }
            })
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let message = messages[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatBubbleCell
        cell.textView.text = message.text
        self.setupChatBubble(cell: cell, message: message)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 100
        
        if let text = messages[indexPath.row].text {
            height = self.getEstimatedFrameForText(text: text).height + 20
        }
        
        let width = UIScreen.main.bounds.width
        
        return CGSize(width: width, height: height)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendButtonDidPress()
        return true
    }
    
    func setupInputContainer() {
        view.addSubview(inputContainer)
        inputContainer.addSubview(topBorder)
        
        inputContainer.heightAnchor.constraint(equalToConstant: 58).isActive = true
        inputContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        inputContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        inputContainerBottomConstraint = inputContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        inputContainerBottomConstraint?.isActive = true
        
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
    
    func setupChatBubble(cell: ChatBubbleCell, message: Message) {
        guard let text = message.text else { return }
        cell.chatBubbleWidthConstraint?.constant = self.getEstimatedFrameForText(text: text).width + 32
        
        if let imageUrl = self.receiver?.imageUrl {
            cell.profileImageView.fetchImage(urlString: imageUrl)
        }
        
        if message.from == self.receiver?.uid {
            cell.chatBubble.backgroundColor = UIColor(240,240,240)
            cell.textView.textColor = UIColor.black
            cell.chatBubbleTrailingConstraint?.isActive = false
            cell.chatBubbleLeadingConstraint?.isActive = true
            cell.profileImageView.isHidden = false
        } else {
            cell.chatBubble.backgroundColor = UIColor(0, 137, 249)
            cell.textView.textColor = UIColor.white
            cell.chatBubbleTrailingConstraint?.isActive = true
            cell.chatBubbleLeadingConstraint?.isActive = false
            cell.profileImageView.isHidden = true
        }
    }
    
    func sendButtonDidPress() {
        if let text = textField.text, text != "" {
            let sender = FIRAuth.auth()!.currentUser!.uid
            let receiver = self.receiver!.uid!
            let ref = FIRDatabase.database().reference().child("messages").childByAutoId()
            let timestamp = Int(NSDate().timeIntervalSince1970)
            let values:[String: Any] = ["from": sender, "to": receiver, "text": text, "timestamp": timestamp]
            ref.updateChildValues(values) {
                (error, ref) in
                
                if error != nil {
                    print(error.debugDescription)
                    return
                }
                
                let senderMessageRef = FIRDatabase.database().reference().child("user-messages").child(sender)
                let receiverMessageRef = FIRDatabase.database().reference().child("user-messages").child(receiver)
                let messageId = ref.key
                senderMessageRef.updateChildValues([messageId:1])
                receiverMessageRef.updateChildValues([messageId:1])
                
                DispatchQueue.main.async {
                    self.textField.text = ""
                    //self.view.endEditing(true)
                }
            }
        }
    }
    
    func setupKeyboardObervers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyBoardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyBoardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    func handleKeyBoardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        guard let keyboardDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] else { return }
        inputContainerBottomConstraint?.constant = -keyboardSize.height
        UIView.animate(withDuration: keyboardDuration as! TimeInterval) { 
            self.view.layoutIfNeeded()
        }
    }
    
    func handleKeyBoardWillHide(notification: Notification) {
        guard let keyboardDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] else { return }
        inputContainerBottomConstraint?.constant = 0
        UIView.animate(withDuration: keyboardDuration as! TimeInterval) {
            self.view.layoutIfNeeded()
        }
    }
}
