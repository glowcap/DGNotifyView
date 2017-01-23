//
//  DGNotifyView.swift
//  Pods
//
//  Created by Daymein Gregorio on 2017/01/23.
//
//

import Foundation
import UIKit


public class DGNotifyViewRounded: DGNotificationView {
    
    
    public init(fromSide: Side, fullWidth: Bool, cornerRadius: CGFloat, title: String, message: String) {
        super.init(fullWidth: fullWidth, side: fromSide, cornerRadius: cornerRadius,
                   image: nil, title: title, message: message)
        configure()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure() {
        //code here
    }
}
