//
//  DGNotificationView.swift
//  Pods
//
//  Created by Daymein Gregorio on 2017/01/23.
//
//

import Foundation
import UIKit

// This is the base class and shouldn't need to be called in most situations
public class DGNotificationView: UIView {
    
    public let dgScreenWidth = UIScreen.main.bounds.width
    public let dgScreenHeight = UIScreen.main.bounds.height
    
    public var displayTime: Double!
    public var title: String!
    public var message: String!
    public var side: Side!
    public var cornerRadius: CGFloat!
    
    private var titleLabel: UILabel!
    private var messageLabel: UILabel!
    private var imageView: UIImageView!
    private var image: UIImage!

    private let vHeight:CGFloat = 68.0
    private let shadowMargin:CGFloat = 4.0
    private let topCarrierMargin:CGFloat = 20.0
    private var xPadding: CGFloat!
    
    public enum Side: CGFloat {
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
        case top
        case bottom
    }
    
    
    public init(fullWidth: Bool, side: Side, cornerRadius: CGFloat, image: UIImage?, title: String, message: String) {
        self.side = side
        self.title = title
        self.message = message
        self.cornerRadius = cornerRadius
        
        if let img = image {
            self.image = img
        }
        
        let frameZero = CGRect.zero
        super.init(frame: frameZero)
        
        self.frame = setStartFrom(side: side, fullWidth: fullWidth)
        configureContents()
        addShadow()
        backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)

    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func addShadow() {
        layer.cornerRadius  = cornerRadius
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowOffset  = CGSize.zero
        layer.shadowRadius  = 5.0
        layer.shadowOpacity = 0.5
        super.backgroundColor = UIColor.clear
    }
    
    private func configureContents() {
        let topMargin:CGFloat = 2
        let imageWH: CGFloat = 64
        let leftLabelMarginWithImage:CGFloat = imageWH + 10
        let labelWidthWithImage:CGFloat = bounds.width - leftLabelMarginWithImage
        
        if image != nil {
            imageView = UIImageView(frame: CGRect(x: 2, y: topMargin, width: imageWH, height: imageWH))
            imageView.image = image!
            imageView.layer.cornerRadius = cornerRadius
            imageView.clipsToBounds = true
            addSubview(imageView)
            
            titleLabel = UILabel(frame: CGRect(x: leftLabelMarginWithImage, y: topMargin, width: labelWidthWithImage, height: 18))
            messageLabel = UILabel(frame: CGRect(x: leftLabelMarginWithImage, y:  topMargin + titleLabel.bounds.height, width: labelWidthWithImage, height: 46))
        } else {
            titleLabel = UILabel(frame: CGRect(x: 8, y: topMargin, width: self.bounds.width - 20, height: 18))
            messageLabel = UILabel(frame: CGRect(x: 8, y:  topMargin + titleLabel.bounds.height, width: self.bounds.width - 20, height: 46))
        }
        
        titleLabel.textAlignment = .left
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.text = title
        titleLabel.font = UIFont(name: titleLabel.font.fontName, size: 16)
        addSubview(titleLabel)
        
        messageLabel.textAlignment = .left
        messageLabel.numberOfLines = 3
        messageLabel.lineBreakMode = .byTruncatingTail
        messageLabel.text = message
        messageLabel.font = UIFont(name: messageLabel.font.fontName, size: 12)
        addSubview(messageLabel)
    }
    
    private func setStartFrom(side: Side, fullWidth: Bool) -> CGRect {
        let frame: CGRect
        let width = fullWidth ? dgScreenWidth : (dgScreenWidth - 40.0)
        xPadding = fullWidth ? 0.0 : 20.0
        
        switch side {
        case .topLeft:
            frame = CGRect(x: -dgScreenWidth + xPadding, y: shadowMargin + topCarrierMargin, width: width, height: vHeight)
        case .topRight:
            frame = CGRect(x: dgScreenWidth + xPadding, y: shadowMargin + topCarrierMargin, width: width, height: vHeight)
        case .bottomLeft:
            frame = CGRect(x: -dgScreenWidth + xPadding, y: dgScreenHeight - vHeight - shadowMargin, width: width, height: vHeight)
        case .bottomRight:
            frame = CGRect(x: dgScreenWidth + xPadding, y: dgScreenHeight - vHeight - shadowMargin, width: width, height: vHeight)
        case .top:
            frame = CGRect(x: xPadding, y: 0 - vHeight - shadowMargin, width: width, height: vHeight)
        case .bottom:
            frame = CGRect(x: xPadding, y: dgScreenHeight + shadowMargin, width: width, height: vHeight)
            
        }
        return frame
    }
    
    public func displayFor(seconds: Double, completion: @escaping (_ finished: Bool) -> Void) {
        guard let s = side else { return }
        let yToPosition1: CGFloat
        let yToPosition2: CGFloat
        let xToPosition1: CGFloat
        let xToPosition2: CGFloat
        
        switch s {
        case .top:
            yToPosition1 = vHeight / 2 + shadowMargin + topCarrierMargin
            yToPosition2 = -vHeight + -shadowMargin
            xToPosition1 = center.x
            xToPosition2 = xToPosition1
        case .topRight, .bottomRight:
            yToPosition1 = center.y
            yToPosition2 = center.y
            xToPosition1 = dgScreenWidth / 2
            xToPosition2 = dgScreenWidth * 1.5 + xPadding
        case .bottom:
            yToPosition1 = dgScreenHeight - vHeight / 2 - shadowMargin
            yToPosition2 = dgScreenHeight + vHeight / 2 + shadowMargin
            xToPosition1 = center.x
            xToPosition2 = xToPosition1
        case .topLeft, .bottomLeft:
            yToPosition1 = center.y
            yToPosition2 = center.y
            xToPosition1 = dgScreenWidth / 2
            xToPosition2 = -dgScreenWidth / 1.5 + -xPadding
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.4, options: [.curveEaseOut], animations: {
            self.center.y = yToPosition1
            self.center.x = xToPosition1
        }, completion: {(done) in
            if done {
                UIView.animate(withDuration: 0.4, delay: seconds, options: [.curveEaseOut], animations: {
                    self.center.y = yToPosition2
                    self.center.x = xToPosition2
                }, completion: { (completed) in
                    completion(true)
                })
            }
        })
    }
    
    
    
}
