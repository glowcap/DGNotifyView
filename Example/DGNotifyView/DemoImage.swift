//
//  DemoImage.swift
//  DGNotifyView
//
//  Created by glowcap on 2017/01/31.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

public class DemoImage : NSObject {

    // Cache
    private struct Cache {
        static var imageOfDemo: UIImage?
        static var demoTargets: [AnyObject]?
    }

    // Drawing Methods
    @objc public dynamic class func drawDemo(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 200, height: 200), resizing: ResizingBehavior = .aspectFit) {
        // General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        // Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 200, height: 200), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 200, y: resizedFrame.height / 200)


        // Color Declarations
        let fillColor = UIColor(red: 0.992, green: 0.571, blue: 0.171, alpha: 1.000)
        let textForeground = UIColor(red: 0.257, green: 0.285, blue: 0.318, alpha: 1.000)
        let textForeground2 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)

        // Group 4
        // Rectangle 2 Drawing
        let rectangle2Path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 200, height: 200))
        fillColor.setFill()
        rectangle2Path.fill()


        // Label 3 Drawing
        let label3Rect = CGRect(x: 7.63, y: 153, width: 184.52, height: 56)
        let label3Style = NSMutableParagraphStyle()
        label3Style.alignment = .left
        let label3FontAttributes = [NSAttributedStringKey.font: UIFont(name: "AvenirNext-Bold", size: 34)!, NSAttributedStringKey.foregroundColor: textForeground2, NSAttributedStringKey.paragraphStyle: label3Style]

        "notify view".draw(in: label3Rect, withAttributes: label3FontAttributes)


        // Label 2 Drawing
        let label2Rect = CGRect(x: -5.23, y: -51, width: 147.06, height: 313)
        let label2Style = NSMutableParagraphStyle()
        label2Style.alignment = .left
        let label2FontAttributes = [NSAttributedStringKey.font: UIFont(name: "AvenirNext-DemiBold", size: 203)!, NSAttributedStringKey.foregroundColor: textForeground, NSAttributedStringKey.paragraphStyle: label2Style]

        "D".draw(in: label2Rect, withAttributes: label2FontAttributes)


        // Label Drawing
        let labelRect = CGRect(x: 48.92, y: -50, width: 146.11, height: 313)
        let labelStyle = NSMutableParagraphStyle()
        labelStyle.alignment = .left
        let labelFontAttributes = [NSAttributedStringKey.font: UIFont(name: "AvenirNext-DemiBold", size: 203)!, NSAttributedStringKey.foregroundColor: textForeground, NSAttributedStringKey.paragraphStyle: labelStyle]

        "G".draw(in: labelRect, withAttributes: labelFontAttributes)
        
        context.restoreGState()

    }

    // Generated Images

    @objc public dynamic class var imageOfDemo: UIImage {
        if Cache.imageOfDemo != nil {
            return Cache.imageOfDemo!
        }

        UIGraphicsBeginImageContextWithOptions(CGSize(width: 200, height: 200), false, 0)
            DemoImage.drawDemo()

        Cache.imageOfDemo = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return Cache.imageOfDemo!
    }

    // Customization Infrastructure

    @IBOutlet dynamic var demoTargets: [AnyObject]! {
        get { return Cache.demoTargets }
        set {
            Cache.demoTargets = newValue
            for target: AnyObject in newValue {
                let _ = target.perform(NSSelectorFromString("setImage:"), with: DemoImage.imageOfDemo)
            }
        }
    }




    @objc public enum ResizingBehavior: Int {
        case aspectFit /// The content is proportionally resized to fit into the target rectangle.
        case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case stretch /// The content is stretched to match the entire target rectangle.
        case center /// The content is centered in the target rectangle, but it is NOT resized.

        public func apply(rect: CGRect, target: CGRect) -> CGRect {
            if rect == target || target == CGRect.zero {
                return rect
            }

            var scales = CGSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)

            switch self {
                case .aspectFit:
                    scales.width = min(scales.width, scales.height)
                    scales.height = scales.width
                case .aspectFill:
                    scales.width = max(scales.width, scales.height)
                    scales.height = scales.width
                case .stretch:
                    break
                case .center:
                    scales.width = 1
                    scales.height = 1
            }

            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }
}
