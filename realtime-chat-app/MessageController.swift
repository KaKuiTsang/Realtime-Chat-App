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

    override func viewDidLoad() {
        super.viewDidLoad()
        let newMessageIcon = UIImage(named: "new_message_icon")
        view.backgroundColor = UIColor.white
        navigationItem.title = "Messages"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: newMessageIcon, style: .plain, target: self, action: #selector
            (handleCreateMessage))
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"Back", style:.plain, target:nil, action:nil)
        tableView.register(MessageCell.self, forCellReuseIdentifier: cellId)
        self.fetchMessages()
    }
    
    func fetchMessages() {
        
        let ref = FIRDatabase.database().reference().child("messages")
        
        ref.observe(.childAdded, with: { (snapshot) in
            
            if let dictionary =  snapshot.value as? [String: AnyObject] {
                let message = Message()
                message.key = snapshot.key
                message.setValuesForKeys(dictionary)
                self.messages.append(message)
                self.messagesDictionary[message.to!] = message
                self.messages = Array(self.messagesDictionary.values)
                self.messages.sort(by: { (message1, message2) -> Bool in
                    return (message1.timestamp?.intValue)! > (message2.timestamp?.intValue)!
                })
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    func handleLogout() {
        do {
            try FIRAuth.auth()?.signOut()

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
        navigationController?.pushViewController(controller, animated: true)
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
}
