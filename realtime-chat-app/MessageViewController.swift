//
//  MainViewController.swift
//  realtime-chat-app
//
//  Created by Tsang Ka Kui on 21/8/2016.
//  Copyright © 2016年 Tsang Ka Kui. All rights reserved.
//

import UIKit
import Firebase

class MessageViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.fetchUser()
        let newMessageIcon = UIImage(named: "new_message_icon")
        view.backgroundColor = UIColor.white
        navigationItem.title = "Messages"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: newMessageIcon, style: .plain, target: self, action: #selector
            (handleCreateMessage))
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"Back", style:.plain, target:nil, action:nil)
    }
    
    /*func fetchUser() {
        
        let uid = FIRAuth.auth()?.currentUser?.uid
        
        FIRDatabase.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: {(snapshot) in
            if let userInfo = snapshot.value as? [String: AnyObject] {
                self.navigationItem.title = userInfo["name"] as? String
            }
        })
    }*/
    
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
        
        let controller = CreateMessageViewController()
        
        navigationController?.pushViewController(controller, animated: true)
        
    }
}
