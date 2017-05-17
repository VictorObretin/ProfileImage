//
//  UIProfileImageView.swift
//  ProfileImage
//
//  Created by Victor Obretin on 2017-01-15.
//  Copyright © 2017 Victor Obretin. All rights reserved.
//

import UIKit

@IBDesignable
class UIProfileImageView: UIView {
    
    @IBInspectable var image: UIImage?
    @IBInspectable var imageScale: CGFloat = 1.0
    
    @IBInspectable var firstLine_out_scale: CGFloat = 1.0
    @IBInspectable var firstLine_in_scale: CGFloat = 0.9
    @IBInspectable var firstLine_color: UIColor = UIColor.black
    
    @IBInspectable var secondLine_out_scale: CGFloat = 1.0
    @IBInspectable var secondLine_in_scale: CGFloat = 0.9
    @IBInspectable var secondLine_color: UIColor = UIColor.black
    
    var centerContainer: UIView?
    var imageLayer: CALayer?
    var imageMask: CAShapeLayer!
    var profileImage: UIImage?
    
    var firstLineLayer: CAShapeLayer?
    var secondLineLayer: CAShapeLayer?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupComponent()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupComponent()
    }
    
    internal func setupComponent() {
        setContainer()
        setImage()
        setImageMask()
        drawLines()
    }
    
    internal func setContainer() {
        if (centerContainer == nil) {
            let minSize = min(bounds.width, bounds.height)
            let minBounds = CGRect.init(origin: CGPoint.init(x: (bounds.width - minSize) / 2.0, y: (bounds.height - minSize) / 2.0), size: CGSize.init(width: minSize, height: minSize))
            
            centerContainer = UIView()
            centerContainer?.frame = minBounds
            self.addSubview(centerContainer!)
        }
    }
    
    internal func setImage() {
        if imageLayer == nil {
            imageLayer = CAShapeLayer()
            imageLayer?.contentsGravity = kCAGravityResizeAspectFill
            centerContainer?.layer.addSublayer(imageLayer!)
        }
        
        if imageLayer != nil {
            if let userPic = profileImage {
                imageLayer?.contents = userPic.cgImage
            } else {
                if let pic = image {
                    imageLayer?.contents = pic.cgImage
                }
            }
        }
    }
    
    internal func setImageMask() {
        if imageMask == nil {
            imageMask = CAShapeLayer()
            centerContainer?.layer.addSublayer(imageMask)
        }
        
        if imageLayer != nil {
            imageLayer?.mask = imageMask
        }
        
        let minImageSize = min(centerContainer!.bounds.width * imageScale, centerContainer!.bounds.height * imageScale)
        var imageBounds = CGRect.init(origin: CGPoint.init(), size: CGSize.init(width: minImageSize, height: minImageSize))
        imageBounds.origin.x = (centerContainer!.bounds.size.width - minImageSize) / 2.0
        imageBounds.origin.y = (centerContainer!.bounds.size.height - minImageSize) / 2.0
        
        imageLayer?.frame = imageBounds
        
        let minSize = min(centerContainer!.bounds.width, centerContainer!.bounds.height)
        var maskBounds = CGRect.init(origin: CGPoint.init(), size: CGSize.init(width: minSize, height: minSize))
        
        imageMask.fillColor = UIColor.black.cgColor
        imageMask.path = getPath(bounds: maskBounds, scale: imageScale).cgPath
        
        maskBounds.origin.x = -imageBounds.origin.x
        maskBounds.origin.y = -imageBounds.origin.y
        imageMask.frame = maskBounds
    }
    
    internal func getPath(bounds: CGRect, scale: CGFloat)->UIBezierPath {
        return UIBezierPath(rect: bounds)
    }
    
    internal func drawLines() {
        drawLine(shapeLayer: &firstLineLayer, outScale: firstLine_out_scale, inScale: firstLine_in_scale, lineColor: firstLine_color)
        drawLine(shapeLayer: &secondLineLayer, outScale: secondLine_out_scale, inScale: secondLine_in_scale, lineColor: secondLine_color)
    }
    
    internal func drawLine(shapeLayer: inout CAShapeLayer?, outScale: CGFloat, inScale: CGFloat, lineColor: UIColor) {
        if (shapeLayer != nil && (outScale <= 0 || inScale >= outScale)) {
            shapeLayer?.removeFromSuperlayer()
            shapeLayer = nil
            return
        }
        
        if (shapeLayer == nil && outScale > 0 && outScale > inScale) {
            shapeLayer = CAShapeLayer.init()
            centerContainer!.layer.addSublayer(shapeLayer!)
        }
        
        if (shapeLayer == nil) {
            return
        }
        
        let minSize = min(centerContainer!.bounds.width, centerContainer!.bounds.height)
        var boundsRect = CGRect.init(origin: CGPoint.init(), size: CGSize.init(width: minSize, height: minSize))
        let shapeBounds = boundsRect
        
        boundsRect.origin.x = (centerContainer!.bounds.width - boundsRect.size.width) / 2.0
        boundsRect.origin.y = (centerContainer!.bounds.height - boundsRect.size.height) / 2.0
        
        shapeLayer?.frame = boundsRect
        
        let path = getPath(bounds: shapeBounds, scale: outScale)
        
        if (inScale > 0) {
            let innerPath = getPath(bounds: shapeBounds, scale: inScale)
            path.append(innerPath)
            path.usesEvenOddFillRule = true
        }
        
        shapeLayer?.path = path.cgPath
        shapeLayer?.fillRule = kCAFillRuleEvenOdd
        shapeLayer?.fillColor = lineColor.cgColor
    }
}
