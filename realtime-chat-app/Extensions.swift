//
//  Extensions.swift
//  realtime-chat-app
//
//  Created by Tsang Ka Kui on 18/8/2016.
//  Copyright © 2016年 Tsang Ka Kui. All rights reserved.
//

import UIKit

extension UIColor  {

    convenience init(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
}
