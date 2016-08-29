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
    
    let cellId = "userCell"
    
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchUsers()
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        navigationItem.title = "Contacts"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
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
        navigationController?.pushViewController(controller, animated: true)
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}
