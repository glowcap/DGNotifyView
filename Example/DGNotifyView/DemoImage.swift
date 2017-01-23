//
//  DemoImage.swift
//  Demo
//
//  Created by  on 2017/01/23.
//  Copyright © 2017 . All rights reserved.



// This is the demo image for the notification
import UIKit

public class DemoImage : NSObject {

    //// Cache

    private struct Cache {
        static var imageOfDemoImg: UIImage?
        static var demoImgTargets: [AnyObject]?
    }

    //// Drawing Methods

    public dynamic class func drawDemoImg(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 60, height: 60), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 60, height: 60), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 60, y: resizedFrame.height / 60)


        //// Color Declarations
        let color = UIColor(red: 0.659, green: 0.565, blue: 0.780, alpha: 1.000)
        let color2 = UIColor(red: 0.667, green: 0.557, blue: 0.224, alpha: 1.000)
        let color3 = UIColor(red: 0.161, green: 0.310, blue: 0.427, alpha: 1.000)

        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 60, height: 60))
        color3.setFill()
        rectanglePath.fill()


        //// Text Drawing
        let textPath = UIBezierPath()
        textPath.move(to: CGPoint(x: 4.74, y: 42.34))
        textPath.addLine(to: CGPoint(x: 4.74, y: 4.68))
        textPath.addLine(to: CGPoint(x: 12.55, y: 4.68))
        textPath.addCurve(to: CGPoint(x: 22.98, y: 8.73), controlPoint1: CGPoint(x: 17.01, y: 4.68), controlPoint2: CGPoint(x: 20.49, y: 6.03))
        textPath.addCurve(to: CGPoint(x: 27.88, y: 23.54), controlPoint1: CGPoint(x: 26.24, y: 12.26), controlPoint2: CGPoint(x: 27.88, y: 17.2))
        textPath.addCurve(to: CGPoint(x: 23.74, y: 38), controlPoint1: CGPoint(x: 27.88, y: 29.78), controlPoint2: CGPoint(x: 26.5, y: 34.6))
        textPath.addCurve(to: CGPoint(x: 13.2, y: 42.34), controlPoint1: CGPoint(x: 21.38, y: 40.89), controlPoint2: CGPoint(x: 17.87, y: 42.34))
        textPath.addLine(to: CGPoint(x: 4.74, y: 42.34))
        textPath.close()
        textPath.move(to: CGPoint(x: 13.78, y: 33.24))
        textPath.addCurve(to: CGPoint(x: 18.64, y: 23.83), controlPoint1: CGPoint(x: 17.02, y: 33.07), controlPoint2: CGPoint(x: 18.64, y: 29.93))
        textPath.addCurve(to: CGPoint(x: 17.4, y: 16.71), controlPoint1: CGPoint(x: 18.64, y: 20.82), controlPoint2: CGPoint(x: 18.23, y: 18.45))
        textPath.addCurve(to: CGPoint(x: 14.07, y: 14.07), controlPoint1: CGPoint(x: 16.58, y: 14.95), controlPoint2: CGPoint(x: 15.47, y: 14.07))
        textPath.addLine(to: CGPoint(x: 13.78, y: 14.07))
        textPath.addLine(to: CGPoint(x: 13.78, y: 33.24))
        textPath.close()
        textPath.move(to: CGPoint(x: 43.38, y: 20.56))
        textPath.addLine(to: CGPoint(x: 56, y: 20.56))
        textPath.addLine(to: CGPoint(x: 56, y: 22.12))
        textPath.addCurve(to: CGPoint(x: 53.12, y: 37.78), controlPoint1: CGPoint(x: 56, y: 29.37), controlPoint2: CGPoint(x: 55.04, y: 34.59))
        textPath.addCurve(to: CGPoint(x: 43.81, y: 43), controlPoint1: CGPoint(x: 51.02, y: 41.26), controlPoint2: CGPoint(x: 47.92, y: 43))
        textPath.addCurve(to: CGPoint(x: 34.32, y: 37.88), controlPoint1: CGPoint(x: 39.78, y: 43), controlPoint2: CGPoint(x: 36.62, y: 41.29))
        textPath.addCurve(to: CGPoint(x: 30.89, y: 23.68), controlPoint1: CGPoint(x: 32.03, y: 34.43), controlPoint2: CGPoint(x: 30.89, y: 29.7))
        textPath.addCurve(to: CGPoint(x: 34.34, y: 9.27), controlPoint1: CGPoint(x: 30.89, y: 17.59), controlPoint2: CGPoint(x: 32.04, y: 12.78))
        textPath.addCurve(to: CGPoint(x: 43.77, y: 4), controlPoint1: CGPoint(x: 36.64, y: 5.76), controlPoint2: CGPoint(x: 39.78, y: 4))
        textPath.addCurve(to: CGPoint(x: 55.28, y: 13.32), controlPoint1: CGPoint(x: 49.06, y: 4), controlPoint2: CGPoint(x: 52.9, y: 7.11))
        textPath.addLine(to: CGPoint(x: 46.52, y: 16.93))
        textPath.addCurve(to: CGPoint(x: 45.62, y: 14.11), controlPoint1: CGPoint(x: 46.39, y: 15.74), controlPoint2: CGPoint(x: 46.09, y: 14.8))
        textPath.addCurve(to: CGPoint(x: 43.86, y: 13.07), controlPoint1: CGPoint(x: 45.16, y: 13.42), controlPoint2: CGPoint(x: 44.57, y: 13.07))
        textPath.addCurve(to: CGPoint(x: 40.13, y: 24.61), controlPoint1: CGPoint(x: 41.37, y: 13.07), controlPoint2: CGPoint(x: 40.13, y: 16.92))
        textPath.addCurve(to: CGPoint(x: 40.95, y: 31.73), controlPoint1: CGPoint(x: 40.13, y: 27.88), controlPoint2: CGPoint(x: 40.4, y: 30.25))
        textPath.addCurve(to: CGPoint(x: 43.58, y: 33.95), controlPoint1: CGPoint(x: 41.5, y: 33.21), controlPoint2: CGPoint(x: 42.38, y: 33.95))
        textPath.addCurve(to: CGPoint(x: 44.88, y: 33.56), controlPoint1: CGPoint(x: 44.05, y: 33.95), controlPoint2: CGPoint(x: 44.49, y: 33.82))
        textPath.addCurve(to: CGPoint(x: 45.86, y: 32.46), controlPoint1: CGPoint(x: 45.27, y: 33.3), controlPoint2: CGPoint(x: 45.6, y: 32.93))
        textPath.addCurve(to: CGPoint(x: 46.49, y: 30.74), controlPoint1: CGPoint(x: 46.13, y: 31.99), controlPoint2: CGPoint(x: 46.34, y: 31.42))
        textPath.addCurve(to: CGPoint(x: 46.72, y: 28.49), controlPoint1: CGPoint(x: 46.64, y: 30.07), controlPoint2: CGPoint(x: 46.72, y: 29.32))
        textPath.addLine(to: CGPoint(x: 43.38, y: 28.49))
        textPath.addLine(to: CGPoint(x: 43.38, y: 20.56))
        textPath.close()
        color.setFill()
        textPath.fill()


        //// Text 2 Drawing
        let text2Rect = CGRect(x: 4, y: 46, width: 51, height: 10)
        let text2TextContent = "NotifyView"
        let text2Style = NSMutableParagraphStyle()
        text2Style.alignment = .center
        let text2FontAttributes = [NSFontAttributeName: UIFont(name: "Futura-CondensedExtraBold", size: 10)!, NSForegroundColorAttributeName: color2, NSParagraphStyleAttributeName: text2Style]

        let text2TextHeight: CGFloat = text2TextContent.boundingRect(with: CGSize(width: text2Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text2FontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: text2Rect)
        text2TextContent.draw(in: CGRect(x: text2Rect.minX, y: text2Rect.minY + (text2Rect.height - text2TextHeight) / 2, width: text2Rect.width, height: text2TextHeight), withAttributes: text2FontAttributes)
        context.restoreGState()
        
        context.restoreGState()

    }

    //// Generated Images

    public dynamic class var imageOfDemoImg: UIImage {
        if Cache.imageOfDemoImg != nil {
            return Cache.imageOfDemoImg!
        }

        UIGraphicsBeginImageContextWithOptions(CGSize(width: 60, height: 60), false, 0)
            DemoImage.drawDemoImg()

        Cache.imageOfDemoImg = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return Cache.imageOfDemoImg!
    }

    //// Customization Infrastructure

    @IBOutlet dynamic var demoImgTargets: [AnyObject]! {
        get { return Cache.demoImgTargets }
        set {
            Cache.demoImgTargets = newValue
            for target: AnyObject in newValue {
                let _ = target.perform(NSSelectorFromString("setImage:"), with: DemoImage.imageOfDemoImg)
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
