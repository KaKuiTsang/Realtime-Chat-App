//
//  CreateMessageViewController.swift
//  realtime-chat-app
//
//  Created by Tsang Ka Kui on 22/8/2016.
//  Copyright © 2016年 Tsang Ka Kui. All rights reserved.
//

import UIKit
import Firebase

class ContactController: UITableViewController {
    
    var messageController: MessageController?
    
    let cellId = "userCell"
    
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchUsers()
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        navigationItem.title = "Contacts"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func fetchUsers() {
        let loggedUserEmail = FIRAuth.auth()?.currentUser?.email
        
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                if dictionary["email"]! as? String != loggedUserEmail {
                    let user = User()
                    user.uid = snapshot.key
                    user.setValuesForKeys(dictionary)
                    self.users.append(user)
                    self.users.sort(by: { (user1, user2) -> Bool in
                        return user1.name! < user2.name!
                    })
                }
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        })
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        cell.profileImageView.fetchImage(urlString: user.imageUrl!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let receiver = self.users[indexPath.row]
        let controller = ChatLogController(collectionViewLayout: UICollectionViewFlowLayout())
        controller.receiver = receiver
        messageController?.navigationController?.pushViewController(controller, animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
}
