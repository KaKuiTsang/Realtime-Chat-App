//
//  Message.swift
//  realtime-chat-app
//
//  Created by Tsang Ka Kui on 26/8/2016.
//  Copyright © 2016年 Tsang Ka Kui. All rights reserved.
//

import UIKit
import Firebase

class Message: NSObject {
    var key: String? 
    var from: String?
    var to: String?
    var text: String?
    var timestamp: NSNumber?
    
    func getChartUserId() -> String?{
        return self.from == FIRAuth.auth()?.currentUser?.uid ? self.to : self.from
    }
}

