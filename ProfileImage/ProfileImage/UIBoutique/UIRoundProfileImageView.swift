//
//  UIRoundProfileImageView.swift
//  ProfileImage
//
//  Created by Victor Obretin on 2017-01-15.
//  Copyright © 2017 Victor Obretin. All rights reserved.
//

import UIKit

@IBDesignable
class UIRoundProfileImageView: UIProfileImageView {
    
    override internal func getPath(bounds: CGRect, scale: CGFloat)->UIBezierPath {
        let resultPath: UIBezierPath = UIBezierPath(ovalIn: bounds)
        UIBezierPath.scalePath(path: resultPath, scale: scale)
        return resultPath
    }
}
