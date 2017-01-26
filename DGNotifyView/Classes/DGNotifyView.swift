//
//  DGNotifyView.swift
//  Pods
//
//  Created by Daymein Gregorio on 2017/01/23.
//
//

import Foundation
import UIKit


public class DGNotifyView: DGNotificationView {
    
    /// Initializes the notification with customizations
    ///
    /// - Parameters:
    ///   - fromSide: the side from which the notification will appear
    ///   - fullWidth: whether the notification should be the full width of the screen
    ///   - title: the title for the notification
    ///   - message: the message for the notification
    public init(fromSide: Side, fullWidth: Bool, title: String, message: String) {
        super.init(fullWidth: fullWidth, side: fromSide, cornerRadius: 0.0,
                   image: nil, title: title, message: message)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
