//
//  DGNotificationView.swift
//  Pods
//
//  Created by Daymein Gregorio on 2017/01/23.
//
//

import Foundation
import UIKit

/// This is the base class for DGNotifyView
public final class DGNotifyView: UIView {
  
  /// Determines where the view will appear from and go to.
  /// Top and bottom values will go to the top or bottom, respectively
  ///
  /// - topLeft: Slides in from the top left side
  /// - topRight: Slides in from the top right side
  /// - bottomLeft: Slides in from the bottom left side
  /// - bottomRight: Slides in from the bottom right side
  /// - top: Slides down from the top
  /// - bottom: Slides up from the bottom
  public enum Direction: CGFloat {
    case top
    case topLeft
    case bottomLeft
    case bottom
    case bottomRight
    case topRight
  }
  
  private var screenWidth: CGFloat { UIScreen.main.bounds.width }
  private var screenHeight: CGFloat { UIScreen.main.bounds.height }
  
  // MARK: - Private Set
  
  /// The title of the notification
  private(set) var title: String
  
  /// The message of the notification
  private(set) var message: String
  
  /// The side which the notification will animate from
  private(set) var direction: Direction
  
  /// The corner radius of the notification and image view
  private(set) var cornerRadius: CGFloat
  
  /// The image used in imageView
  /// ** imageView's width and height are 60.0 **
  private(set) var image: UIImage?
  
  /// Animate in with spring animation
  private(set) var useSprings: Bool
  
  /// Set font
  private(set) var font: UIFont?
  
  // MARK: - Private config varibles
  
  private lazy var imageView: UIImageView = {
    let iV = UIImageView()
    iV.image = image
    iV.layer.cornerRadius = cornerRadius
    iV.contentMode = .scaleAspectFit
    iV.clipsToBounds = true
    iV.accessibilityLabel = "notification icon"
    
    iV.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      iV.heightAnchor.constraint(equalToConstant: imageSize),
      iV.widthAnchor.constraint(equalToConstant: imageSize)
    ])
    return iV
  }()
  
  private lazy var titleLabel: UILabel = {
    let lbl = UILabel()
    lbl.textAlignment = .left
    lbl.text = title
    lbl.textColor = textColor
    lbl.adjustsFontSizeToFitWidth = true
    lbl.font = UIFont.systemFont(ofSize: 16)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      lbl.heightAnchor.constraint(equalToConstant: 18)
    ])
    return lbl
  }()
  
  private lazy var messageLabel: UILabel = {
    let lbl = UILabel()
    lbl.textAlignment = .left
    lbl.numberOfLines = 3
    lbl.lineBreakMode = .byTruncatingTail
    lbl.text = message
    lbl.textColor = textColor
    lbl.font = UIFont.systemFont(ofSize: 12)
    return lbl
  }()
  
  private lazy var labelStack: UIStackView = {
    let vStack = UIStackView(arrangedSubviews: [
      titleLabel, messageLabel
    ])
    vStack.axis = .vertical
    vStack.distribution = .fillProportionally
    vStack.spacing = 4
    return vStack
  }()
  
  private let contentStack: UIStackView = {
    let hStack = UIStackView()
    hStack.spacing = 8
    return hStack
  }()
  
  // MARK: Private layout constants
  private let padding = CGFloat(10)
  private let shadowMargin = CGFloat(4)
  private let imageSize = CGFloat(80)
  private let iPadWidths = CGFloat(600)
  
  private var vHeight: CGFloat {
    imageSize + (padding * 2)
  }

  /// generic values to avoid optionals
  private var originPoint = CGPoint(
    x: CGFloat.greatestFiniteMagnitude,
    y: CGFloat.greatestFiniteMagnitude
  )
  
  // MARK: Color variables
  private var textColor = UIColor.darkText {
    didSet {
      if let titleText = titleLabel.text, !titleText.isEmpty {
        titleLabel.textColor = textColor
      }
      if let msgText = messageLabel.text, !msgText.isEmpty {
        messageLabel.textColor = textColor
      }
    }
  }
  
  //MARK: - Init function
  
  /// Base init function for all DGNotifyViews. Call with the parameters
  /// you need and everything else will be handled behind the scenes.
  ///
  /// - Parameters:
  ///   - title: Title of the notification
  ///   - message: Message of the notification
  ///   - direction: The direction the notification will appear from (defaults from top)
  ///   - fullWidth: Notification should be the full width of the screen (defaults to false)
  ///   - cornerRadius: The radius of both the view and image view (defaults to 4)
  ///   - font: Font for title and message (defaults to system font)
  ///   - image: UIImage used for the view (defaults to nil)
  ///   - useSprings: Determines if the notification should bounce into view (defaults to false)
  public init(
    title: String = "",
    message: String = "",
    direction: Direction = .top,
    fullWidth: Bool = false,
    cornerRadius: CGFloat = 4.0,
    font: UIFont? = nil,
    image: UIImage? = nil,
    useSprings: Bool = false) {
      
      self.title = title
      self.message = message
      self.direction = direction
      self.cornerRadius = cornerRadius
      self.useSprings = useSprings
      
      if let font = font {
        self.font = font
      }
      
      if let image = image {
        self.image = image
      }
      
      super.init(frame: CGRect.zero)
      self.frame = setStartFrom(direction: direction, fullWidth: fullWidth)
      
      configure(
        contentStack: contentStack,
        labelStack: labelStack,
        imageView: imageView)
      layoutContent()
      addShadow()
      
      if #available(iOS 13.0, *) {
        backgroundColor = UIColor.systemGroupedBackground
        accessibilityUserInputLabels = [
          (titleLabel.text ?? ""),
          (messageLabel.text ?? "")
        ]
      } else {
        backgroundColor = UIColor.groupTableViewBackground
        accessibilityLabel = "\(titleLabel.text ?? "") \(messageLabel.text ?? "")"
      }
    }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  /// Configures the notification content
  /// - Parameters:
  ///   - contentStack: contentStack to add content
  ///   - labelStack: UIStack of title and message
  ///   - imageView: image view to be added
  ///   - Note: imageVIew will only be added if image != nil
  private func configure(contentStack: UIStackView, labelStack: UIStackView, imageView: UIImageView) {
    if imageView.image != nil {
      contentStack.addArrangedSubview(imageView)
    }
    contentStack.addArrangedSubview(labelStack)
  }
  
  private func layoutContent() {
    addSubview(contentStack)
    contentStack.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      contentStack.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
      contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
      contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
      contentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
    ])
  }
  
  private func addShadow() {
    layer.cornerRadius = cornerRadius
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize.zero
    layer.shadowRadius = 5.0
    layer.shadowOpacity = 0.5
    super.backgroundColor = UIColor.clear
  }
  
  /// Used to customize the color of the title, message and background.
  /// If a parameter value is set to 'nil', it will remain the default color.
  ///
  /// - Parameters:
  ///   - txtColor: UIColor for all in view text (optional)
  ///   - bgColor: UIColor for view background
  public func set(textColor: UIColor = .darkText, backgroundColor: UIColor = UIColor.groupTableViewBackground) {
    self.textColor = textColor
    self.backgroundColor = backgroundColor
  }
  
  /// Returns the CGRect for the starting position of the notification.
  /// This should not be called directly
  ///
  /// - Parameters:
  ///   - direction: sets the direction from which the notification will appear
  ///   - fullWidth: determines if the notification will cover the full width of the screen
  /// - Returns: the starting rect of the notification
  private func setStartFrom(direction: Direction, fullWidth: Bool) -> CGRect {
    var width = fullWidth ? screenWidth : (screenWidth - 40.0)
    if screenWidth >= iPadWidths { width = 460 }
    originPoint = getOrigin(for: direction, fullWidth: fullWidth)
    return CGRect(
      x: originPoint.x,
      y: originPoint.y,
      width: width,
      height: vHeight
    )
  }
  
  /// The origin point of the notification based on the incoming direction
  /// - Parameters:
  ///   - direction: direction from which the notification will be displayed
  ///   - fullWidth: notification should be displayed the full width of the screen
  /// - Returns: CGPoint of the origin point
  private func getOrigin(for direction: Direction, fullWidth: Bool) -> CGPoint {
    let xPadding = fullWidth ? 0.0 : 20.0
    let safeArea = CGFloat(40)
    let bottomMargin = screenHeight - safeArea
    
    let xPos: CGFloat
    let yPos: CGFloat
    
    switch direction {
    case .topLeft:
      xPos =  -screenWidth + xPadding
      yPos =  shadowMargin + safeArea
    case .topRight:
      xPos = screenWidth + xPadding
      yPos = shadowMargin + safeArea
    case .bottomLeft:
      xPos = -screenWidth + xPadding
      yPos = bottomMargin - vHeight - shadowMargin
    case .bottomRight:
      xPos = screenWidth + xPadding
      yPos = bottomMargin - vHeight - shadowMargin
    case .top:
      xPos = xPadding
      yPos = -(vHeight + shadowMargin)
    case .bottom:
      xPos = xPadding
      yPos = screenHeight + shadowMargin
      
    }
    return CGPoint(x: xPos, y: yPos)
  }
  
  /// Final poisition of the notification when displayed
  /// - Parameter direction: direction from which the notification will be displayed
  /// - Returns: CGPoint to where the notification will animate
  private func displayPosition(for direction: Direction) -> CGPoint {
    let xPos: CGFloat
    let yPos: CGFloat
    
    switch direction {
    case .top:
      yPos = vHeight
      xPos = center.x
    case .topRight, .bottomRight:
      yPos = center.y
      xPos = screenWidth / 2
    case .bottom:
      yPos = screenHeight - vHeight
      xPos = center.x
    case .topLeft, .bottomLeft:
      yPos = center.y
      xPos = screenWidth / 2
    }
    return CGPoint(x: xPos, y: yPos)
  }
  
}

// MARK: - Animation functions
extension DGNotifyView {

  /// Animates the view into and out of the device's viewable area.
  /// - Parameters:
  ///   - direction: Direction from which the notification will come
  ///   - seconds: Time the notification view will stay on screen (not including animation time)
  ///   - completion: Use this closure to do something after the view has animated off screen
  public func display(from direction: Direction, for seconds: Double = 1.0, completion: @escaping (_ finished: Bool) -> Void) {
    let displayPosition = displayPosition(for: direction)
    
    if useSprings {
      springToLife(
        lifetime: seconds,
        from: direction,
        origin: originPoint,
        toPosition: displayPosition,
        completion: completion
      )
    } else {
      comeToLife(
        lifetime: seconds,
        from: direction,
        origin: originPoint,
        toPosition: displayPosition,
        completion: completion
      )
    }
  }
  
  private func comeToLife(lifetime: Double, from direction: Direction, origin: CGPoint, toPosition: CGPoint, completion: @escaping (Bool) -> Void) {
    UIView.animate(
      withDuration: 0.5,
      delay: 0.0,
      options: .curveEaseInOut,
      animations: {
        switch direction {
        case .top, .bottom:
          self.center.y = toPosition.y
        default:
          self.center.x = toPosition.x
        }
      },
      completion: { done in
        guard done else { return }
        UIView.animate(
          withDuration: 0.4,
          delay: lifetime,
          options: [.curveEaseOut],
          animations: {
            switch direction {
            case .top, .bottom:
              self.center.y = origin.y
            default:
              self.center.x = origin.x
            }
        },
          completion: { done in completion(done) }
        )
      }
    )
  }
  
  private func springToLife(lifetime: Double, from direction: Direction, origin: CGPoint, toPosition: CGPoint, completion: @escaping (Bool) -> Void) {
    UIView.animate(
      withDuration: 0.5,
      delay: 0.0,
      usingSpringWithDamping: 0.5,
      initialSpringVelocity: 0.8,
      options: .curveEaseInOut,
      animations: {
        switch direction {
        case .top, .bottom:
          self.center.y = toPosition.y
        default:
          self.center.x = toPosition.x
        }
      },
      completion: { done in
        guard done else { return }
        UIView.animate(
          withDuration: 0.4,
          delay: lifetime,
          options: [.curveEaseOut],
          animations: {
            switch direction {
            case .top, .bottom:
              self.center.y = origin.y
            default:
              self.center.x = origin.x
            }
        },
          completion: { done in completion(done) }
        )
      })
  }
  
}
