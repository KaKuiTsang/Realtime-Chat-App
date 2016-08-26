//
//  Extensions.swift
//  realtime-chat-app
//
//  Created by Tsang Ka Kui on 18/8/2016.
//  Copyright © 2016年 Tsang Ka Kui. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIColor  {

    convenience init(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
}

extension UIImageView {
    
    func fetchImage(urlString: String) {
        
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as AnyObject)
                    self.image = image
                }
            }
            
        }.resume()
        
    }
    
}
