//
//  DGNotificationView.swift
//  Pods
//
//  Created by Daymein Gregorio on 2017/01/23.
//
//

import Foundation
import UIKit

/// This is the base class for DGNotifyView and shouldn't need to be called in most situations
public class DGNotificationView: UIView {
    
    
    /// Determines where the view will appear from and go to.
    /// Top and bottom values will go to the top or bottom, respectively
    ///
    /// - topLeft: Slides in from the top left side
    /// - topRight: Slides in from the top right side
    /// - bottomLeft: Slides in from the bottom left side
    /// - bottomRight: Slides in from the bottom right side
    /// - top: Slides down from the top
    /// - bottom: Slides up from the bottom
    public enum Side: CGFloat {
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
        case top
        case bottom
    }
    
    static let dgScreenWidth = UIScreen.main.bounds.width
    static let dgScreenHeight = UIScreen.main.bounds.height

//MARK: - Private variables
    private var _displayTime: Double!
    private var _title: String!
    private var _message: String!
    private var _side: Side!
    private var _cornerRadius: CGFloat!
    private var _image: UIImage!
    private var _useSprings: Bool!
    

//MARK: - Public (read only)
    /// The number of seconds the notification should be displayed
    public var displayTime: Double {
        get {
            return _displayTime
        }
    }
    
    
    /// The title of the notification
    public var title: String {
        get {
            return _title
        }
    }
    
    
    /// The message of the notification
    public var message: String {
        get {
            return _message
        }
    }

    
    /// The side which the notification will animate from
    public var side: Side {
        get {
            return _side
        }
    }
    
    
    /// The corner radius of the notification and image view
    public var cornerRadius: CGFloat {
        get {
            return _cornerRadius
        }
    }
    
    
    /// The image used in imageView
    /// ** imageView's width and height are 60.0 **
    public var image: UIImage {
        get {
            return _image
        }
    }
    
    /// Animate in with spring animation
    public var useSprings: Bool {
        get {
            return _useSprings
        }
    }

//MARK: - Private config varibles
    private var titleLabel: UILabel!
    private var messageLabel: UILabel!
    private var imageView: UIImageView!

//MARK: Layout variables
    private let vHeight:CGFloat = 68.0
    private let shadowMargin:CGFloat = 4.0
    private let topCarrierMargin:CGFloat = 20.0
    private var xPadding: CGFloat!
    
//MARK: Color variables
    private var textColor = UIColor.darkText {
        didSet {
            guard titleLabel != nil, messageLabel != nil else { return }
            titleLabel.textColor = textColor
            messageLabel.textColor = textColor
        }
    }
    
    private var bgColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1) {
        didSet {
            backgroundColor = bgColor
        }
    }
    
//MARK: - Init functions
    
    /// Base init function for all DGNotifyViews. This should not be called directly.
    /// Instead, call one of the subclasses and init with their parameters. Everything
    /// else will be handled behind the scenes
    ///
    /// - Parameters:
    ///   - fullWidth: view should span the full width of the screen
    ///   - side: which side the view will appear from
    ///   - cornerRadius: the radius of both the view and image view (if applicable)
    ///   - image: UIImage used for the view (if applicable)
    ///   - useSprings: should use spring animation to enter view
    ///   - title: notification title
    ///   - message: notification message
    public init(fullWidth: Bool, side: Side, cornerRadius: CGFloat, image: UIImage?,
                useSprings: Bool, title: String, message: String) {
        _side = side
        _title = title
        _message = message
        _useSprings = useSprings
        _cornerRadius = cornerRadius
        
        if let img = image {
            _image = img
        }
        
        let frameZero = CGRect.zero
        super.init(frame: frameZero)
        
        self.frame = setStartFrom(side: side, fullWidth: fullWidth)
        configureContents()
        addShadow()
        backgroundColor = bgColor
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
//MARK: - Configuration functions
    /// Configures the contents of the notification. This cannot be accessed directly
    private func configureContents() {
        let topMargin:CGFloat = 4
        let imageWH: CGFloat = 60
        let leftLabelMarginWithImage:CGFloat = imageWH + 10
        let labelWidthWithImage:CGFloat = bounds.width - leftLabelMarginWithImage
        
        if _image != nil {
            imageView = UIImageView(frame: CGRect(x: 4, y: topMargin, width: imageWH, height: imageWH))
            imageView.image = image
            imageView.layer.cornerRadius = cornerRadius
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            addSubview(imageView)
            
            titleLabel = UILabel(frame: CGRect(x: leftLabelMarginWithImage,
                                               y: topMargin,
                                               width: labelWidthWithImage,
                                               height: 18))
            messageLabel = UILabel(frame: CGRect(x: leftLabelMarginWithImage,
                                                 y:  topMargin + titleLabel.bounds.height,
                                                 width: labelWidthWithImage,
                                                 height: 46))
        } else {
            titleLabel = UILabel(frame: CGRect(x: 8,
                                               y: topMargin,
                                               width: self.bounds.width - 20,
                                               height: 18))
            messageLabel = UILabel(frame: CGRect(x: 8,
                                                 y:  topMargin + titleLabel.bounds.height,
                                                 width: self.bounds.width - 20,
                                                 height: 46))
        }
        
        titleLabel.textAlignment = .left
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.text = title
        titleLabel.textColor = textColor
        titleLabel.font = UIFont(name: titleLabel.font.fontName, size: 16)
        addSubview(titleLabel)
        
        messageLabel.textAlignment = .left
        messageLabel.numberOfLines = 3
        messageLabel.lineBreakMode = .byTruncatingTail
        messageLabel.text = message
        messageLabel.textColor = textColor
        messageLabel.font = UIFont(name: messageLabel.font.fontName, size: 12)
        addSubview(messageLabel)
    }
    
    
    private func addShadow() {
        layer.cornerRadius  = cornerRadius
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowOffset  = CGSize.zero
        layer.shadowRadius  = 5.0
        layer.shadowOpacity = 0.5
        super.backgroundColor = UIColor.clear
    }
    
    
    /// Returns the CGRect for the starting position of the notification.
    /// This should not be called directly
    ///
    /// - Parameters:
    ///   - side: set the location from which the notification will appear
    ///   - fullWidth: determines if the notification will cover the full width of the screen
    /// - Returns: the starting postion of the notification
    private func setStartFrom(side: Side, fullWidth: Bool) -> CGRect {
        let frame: CGRect
        let width = fullWidth ? DGNotificationView.dgScreenWidth : (DGNotificationView.dgScreenWidth - 40.0)
        xPadding = fullWidth ? 0.0 : 20.0
        
        switch side {
        case .topLeft:
            frame = CGRect(x: -DGNotificationView.dgScreenWidth + xPadding,
                           y: shadowMargin + topCarrierMargin,
                           width: width, height: vHeight)
        case .topRight:
            frame = CGRect(x: DGNotificationView.dgScreenWidth + xPadding,
                           y: shadowMargin + topCarrierMargin,
                           width: width, height: vHeight)
        case .bottomLeft:
            frame = CGRect(x: -DGNotificationView.dgScreenWidth + xPadding,
                           y: DGNotificationView.dgScreenHeight - vHeight - shadowMargin,
                           width: width, height: vHeight)
        case .bottomRight:
            frame = CGRect(x: DGNotificationView.dgScreenWidth + xPadding,
                           y: DGNotificationView.dgScreenHeight - vHeight - shadowMargin,
                           width: width, height: vHeight)
        case .top:
            frame = CGRect(x: xPadding,
                           y: 0 - vHeight - shadowMargin,
                           width: width, height: vHeight)
        case .bottom:
            frame = CGRect(x: xPadding,
                           y: DGNotificationView.dgScreenHeight + shadowMargin,
                           width: width, height: vHeight)
            
        }
        return frame
    }
    
    
    /// Used to customize the color of the title, message and background.
    /// If a parameter value is set to 'nil', it will remain the default color.
    ///
    /// - Parameters:
    ///   - txtColor: UIColor for all in view text (optional)
    ///   - bgColor: UIColor for view background (optional)
    public func set(txtColor: UIColor?, bgColor: UIColor?) {
        if txtColor != nil { textColor = txtColor! }
        guard bgColor != nil else { return }
        backgroundColor = bgColor
    }
    
//MARK: - Animation functions
    /// Animates the view into and out of the device's viewable area.
    ///
    /// - Parameters:
    ///   - seconds: Time the notification view will stay on screen (not including animation time)
    ///   - completion: Use this closure to do something after the view has animated off screen
    public func displayFor(seconds: Double, completion: @escaping (_ finished: Bool) -> Void) {
        let s = side
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
            xToPosition1 = DGNotificationView.dgScreenWidth / 2
            xToPosition2 = DGNotificationView.dgScreenWidth * 1.5 + xPadding
        case .bottom:
            yToPosition1 = DGNotificationView.dgScreenHeight - vHeight / 2 - shadowMargin
            yToPosition2 = DGNotificationView.dgScreenHeight + vHeight / 2 + shadowMargin
            xToPosition1 = center.x
            xToPosition2 = xToPosition1
        case .topLeft, .bottomLeft:
            yToPosition1 = center.y
            yToPosition2 = center.y
            xToPosition1 = DGNotificationView.dgScreenWidth / 2
            xToPosition2 = -DGNotificationView.dgScreenWidth / 1.5 + -xPadding
        }
        
        if useSprings {
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
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
        } else {
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
    
    
    
}
