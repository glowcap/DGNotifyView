//
//  DGNotifyViewRoundedImgSpringy.swift
//  Pods
//
//  Created by Daymein Gregorio on 2017/01/31.
//
//

import Foundation
import UIKit


public class DGNotifyViewRoundedImgSpringy: DGNotificationView {
    
    /// Initializes the notification with customizations
    ///
    /// - Parameters:
    ///   - fromSide: the side from which the notification will appear
    ///   - fullWidth: whether the notification should be the full width of the screen
    ///   - cornerRadius: the corner radius of the notification
    ///   - title: the title for the notification
    ///   - message: the message for the notification
    ///   - img: UIImage used in the notification **img size 64.0**
    public init(fromSide: Side, fullWidth: Bool, cornerRadius: CGFloat, title: String, message: String, img: UIImage) {
        super.init(fullWidth: fullWidth, side: fromSide, cornerRadius: cornerRadius,
                   image: img, useSprings: true, title: title, message: message)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
