//
//  NavigationController.swift
//  realtime-chat-app
//
//  Created by Tsang Ka Kui on 20/8/2016.
//  Copyright © 2016年 Tsang Ka Kui. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let messageController = MessageController()
        viewControllers.append(messageController)
    }

}
