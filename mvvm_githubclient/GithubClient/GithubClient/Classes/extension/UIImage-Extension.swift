//
//  UIImage-Extension.swift
//  GithubClient
//
//  Created by kazuya on 2019/10/16.
//  Copyright © 2019 K.Hatano. All rights reserved.
//

import UIKit

extension UIImage {
    
    /**
     色とサイズを指定してUIImageを作成する
     */
    convenience init?(color: UIColor, size: CGSize) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else {return nil}
        
        self.init(cgImage: cgImage)
    }
}
