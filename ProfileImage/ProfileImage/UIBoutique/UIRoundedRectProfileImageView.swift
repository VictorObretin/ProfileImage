//
//  UIRoundedRectProfileImageView.swift
//  ProfileImage
//
//  Created by Victor Obretin on 2017-01-18.
//  Copyright © 2017 Victor Obretin. All rights reserved.
//

import UIKit

@IBDesignable
class UIRoundedRectProfileImageView: UIProfileImageView {
    
    @IBInspectable var cornerRadius: CGFloat = 20.0
    
    override internal func getPath(bounds: CGRect, scale: CGFloat)->UIBezierPath {
        let resultPath: UIBezierPath = UIBezierPath(roundedPolygonPathWithRect: bounds, sides: 4, cornerRadius: cornerRadius * scale)
        UIBezierPath.scalePath(path: resultPath, scale: scale)
        return resultPath
    }
}
