//
//  UIRoundedHexProfileImageView.swift
//  ProfileImage
//
//  Created by Victor Obretin on 2017-01-18.
//  Copyright © 2017 Victor Obretin. All rights reserved.
//

import UIKit

@IBDesignable
class UIRoundedHexProfileImageView: UIProfileImageView {
    
    @IBInspectable var cornerRadius: CGFloat = 20.0
    
    override internal func getPath(bounds: CGRect, scale: CGFloat)->UIBezierPath {
        let resultPath: UIBezierPath = UIBezierPath(roundedPolygonPathWithRect: bounds, sides: 6, cornerRadius: cornerRadius * scale)
        UIBezierPath.rotatePath(path: resultPath, theta: CGFloat.pi / 2.0)
        UIBezierPath.scalePath(path: resultPath, scale: scale)
        return resultPath
    }
}
