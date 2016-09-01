//
//  MainViewController.swift
//  realtime-chat-app
//
//  Created by Tsang Ka Kui on 21/8/2016.
//  Copyright © 2016年 Tsang Ka Kui. All rights reserved.
//

import UIKit
import Firebase

class MessageController: UITableViewController {
    
    let cellId = "messageCell"
    
    var messages = [Message]()
    
    var messagesDictionary = [String: Message]()
    
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        let newMessageIcon = UIImage(named: "new_message_icon")
        view.backgroundColor = UIColor.white
        navigationItem.title = "Messages"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: newMessageIcon, style: .plain, target: self, action: #selector
            (handleCreateMessage))
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"Messages", style:.plain, target:nil, action:nil)
        tableView.register(MessageCell.self, forCellReuseIdentifier: cellId)
        self.fetchMessages()
    }
    
    func fetchMessages() {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }
        let ref = FIRDatabase.database().reference().child("user-messages").child(uid)
        ref.observe(.childAdded, with: { (snapshot) in
            let messageId = snapshot.key
            let messageRef = FIRDatabase.database().reference().child("messages").child(messageId)
            
            messageRef.observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary =  snapshot.value as? [String: AnyObject] {
                    let message = Message()
                    message.key = snapshot.key
                    message.setValuesForKeys(dictionary)
                    self.messages.append(message)
                    self.messagesDictionary[message.getChartUserId()!] = message
                    self.messages = Array(self.messagesDictionary.values)
                    self.messages.sort(by: { (message1, message2) -> Bool in
                        return (message1.timestamp?.intValue)! > (message2.timestamp?.intValue)!
                    })
                    self.timer?.invalidate()
                    self.timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.handleTableReload), userInfo: nil, repeats: false)
                }
            })
        })
    }
    
    func handleTableReload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func handleLogout() {
        do {
            try FIRAuth.auth()?.signOut()
            messages.removeAll()
            messagesDictionary.removeAll()

            if self.isBeingPresented == true {
                dismiss(animated: true, completion: nil)
            } else {
                let controller = LoginController()
                present(controller, animated: true, completion: nil)
            }
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func handleCreateMessage() {
        let controller = ContactController()
        controller.messageController = self
        let navigation = UINavigationController(rootViewController: controller)
        self.present(navigation, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = self.messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MessageCell
        cell.message = message
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = self.messages[indexPath.row]
        if let uid = message.getChartUserId() {
            let ref = FIRDatabase.database().reference().child("users").child(uid)
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    let receiver = User()
                    receiver.uid = uid
                    receiver.setValuesForKeys(dictionary)
                    let controller = ChatLogController(collectionViewLayout: UICollectionViewFlowLayout())
                    controller.receiver = receiver
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            })
        }
    }
}
