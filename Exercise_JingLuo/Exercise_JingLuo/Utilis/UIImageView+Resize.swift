//
//  UIImageView+Resize.swift
//  Exercise_JingLuo
//
//  Created by JINGLUO on 28/2/18.
//  Copyright © 2018 Jing LUO. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func resizeFrameWith(_ image: UIImage, restrictedByWidth width: CGFloat) -> CGSize {
        let ratio = image.size.height / image.size.width
        let newHeight = width * ratio
        return CGSize(width: width, height: newHeight)
    }
    
    func resizeFrameWith(_ image: UIImage, restrictedByHeight height: CGFloat) -> CGSize {
        let ratio = image.size.width / image.size.height
        let newWidth = height * ratio
        return CGSize(width: newWidth, height: height)
    }
}
