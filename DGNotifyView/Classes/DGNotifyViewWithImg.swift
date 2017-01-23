//
//  NotifyViewWithImg.swift
//  Pods
//
//  Created by Daymein Gregorio on 2017/01/23.
//
//

import Foundation
import UIKit


public class DGNotifyViewWithImg: DGNotificationView {
    
    
    public init(fromSide: Side, fullWidth: Bool, title: String, message: String, img: UIImage) {
        super.init(fullWidth: fullWidth, side: fromSide, cornerRadius: 0.0, image: img, title: title, message: message)
        configure()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure() {
        //code here
    }
}
