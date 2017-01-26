//
//  ViewController.swift
//  DGNotifyView
//
//  Created by glowcap on 01/23/2017.
//  Copyright (c) 2017 glowcap. All rights reserved.
//

import UIKit
import DGNotifyView

class ViewController: UIViewController {
    
    // I'm calling the top-level class because I'm using
    // a variety of notifications for the demo. If you're
    // using a single type, just initiate that one ex: 'myNote: DGNotifyView!'
    var notifyView: DGNotificationView!
    
    var displaySeconds: Double! {
        didSet {
            secondLabel.text = String(displaySeconds)
        }
    }
    
    @IBOutlet weak var rCornersSwitch: UISwitch!
    @IBOutlet weak var imgSwitch: UISwitch!
    @IBOutlet weak var fullWidthSwitch: UISwitch!
    @IBOutlet weak var secondSlider: UISlider!
    @IBOutlet weak var secondLabel: UILabel!
    
    let noteTitle = "Sample Notification"
    let noteMessage = "This message can contain up to 3 lines of text. The text is required on initialization. Once initialized you can call the view to slide in from one of six locations."

    override func viewDidLoad() {
        super.viewDidLoad()
        
        displaySeconds = roundedOffSlider(value: secondSlider.value)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Here the instance of DGNotificationView is being recycled
    // so I'm wiping out the exisiting one
    private func nilNotifyView() {
        notifyView.removeFromSuperview()
        notifyView = nil
    }

    private func roundedOffSlider(value: Float) -> Double {
        let rounded = Double(round(value))

        return rounded
    }
    
    
    // This IBAction looks crazy since I'm demoing every type of DGNotificationView from
    // every location. I don't recommend doing this. lol.
    // Here's an example of how yours might look:
//
//    func showNote() {
//        notifyView = DGNotifyViewRounded(fromSide: .top, fullWidth: false, cornerRadius: 5.0,
//                                         title: "Title", message: "My important message for the user")
//        
//        view.addSubview(notifyView) <- be sure to do this or you'll have a bad time
//        notifyView.displayFor(seconds: 0.5) { (finished) in 
//              do cool stuff after the animation is finished
//        }
//    }
//
    @IBAction func notifyBtnTapped(_ sender: UIButton) {
        sender.isEnabled = false
        let roundCorners = rCornersSwitch.isOn
        let hasImage  = imgSwitch.isOn
        let fullWidth = fullWidthSwitch.isOn
        let cr:CGFloat = 5.0
        
        switch sender.tag {
        case 0:
            if roundCorners && !hasImage {
              notifyView = DGNotifyViewRounded(fromSide: .topLeft, fullWidth: fullWidth, cornerRadius: cr, title: noteTitle, message: noteMessage)
            } else if roundCorners && hasImage {
                notifyView = DGNotifyViewRoundedWithImg(fromSide: .topLeft, fullWidth: fullWidth, cornerRadius: cr, title: noteTitle, message: noteMessage, img: DemoImage.imageOfDemoImg)
            } else if !roundCorners && !hasImage {
                notifyView = DGNotifyView(fromSide: .topLeft, fullWidth: fullWidth, title: noteTitle, message: noteMessage)
            } else {
                notifyView = DGNotifyViewWithImg(fromSide: .topLeft, fullWidth: fullWidth, title: noteTitle, message: noteMessage, img: DemoImage.imageOfDemoImg)
            }
        case 1:
            if roundCorners && !hasImage {
                notifyView = DGNotifyViewRounded(fromSide: .top, fullWidth: fullWidth, cornerRadius: cr, title: noteTitle, message: noteMessage)
            } else if roundCorners && hasImage {
                notifyView = DGNotifyViewRoundedWithImg(fromSide: .top, fullWidth: fullWidth, cornerRadius: cr, title: noteTitle, message: noteMessage, img: DemoImage.imageOfDemoImg)
            } else if !roundCorners && !hasImage {
                notifyView = DGNotifyView(fromSide: .top, fullWidth: fullWidth, title: noteTitle, message: noteMessage)
            } else {
                notifyView = DGNotifyViewWithImg(fromSide: .top, fullWidth: fullWidth, title: noteTitle, message: noteMessage, img: DemoImage.imageOfDemoImg)
            }
        case 2:
            if roundCorners && !hasImage {
                notifyView = DGNotifyViewRounded(fromSide: .topRight, fullWidth: fullWidth, cornerRadius: cr, title: noteTitle, message: noteMessage)
            } else if roundCorners && hasImage {
                notifyView = DGNotifyViewRoundedWithImg(fromSide: .topRight, fullWidth: fullWidth, cornerRadius: cr, title: noteTitle, message: noteMessage, img: DemoImage.imageOfDemoImg)
            } else if !roundCorners && !hasImage {
                notifyView = DGNotifyView(fromSide: .topRight, fullWidth: fullWidth, title: noteTitle, message: noteMessage)
            } else {
                notifyView = DGNotifyViewWithImg(fromSide: .topRight, fullWidth: fullWidth, title: noteTitle, message: noteMessage, img: DemoImage.imageOfDemoImg)
            }
        case 3:
            if roundCorners && !hasImage {
                notifyView = DGNotifyViewRounded(fromSide: .bottomLeft, fullWidth: fullWidth, cornerRadius: cr, title: noteTitle, message: noteMessage)
            } else if roundCorners && hasImage {
                notifyView = DGNotifyViewRoundedWithImg(fromSide: .bottomLeft, fullWidth: fullWidth, cornerRadius: cr, title: noteTitle, message: noteMessage, img: DemoImage.imageOfDemoImg)
            } else if !roundCorners && !hasImage {
                notifyView = DGNotifyView(fromSide: .bottomLeft, fullWidth: fullWidth, title: noteTitle, message: noteMessage)
            } else {
                notifyView = DGNotifyViewWithImg(fromSide: .bottomLeft, fullWidth: fullWidth, title: noteTitle, message: noteMessage, img: DemoImage.imageOfDemoImg)
            }
        case 4:
            if roundCorners && !hasImage {
                notifyView = DGNotifyViewRounded(fromSide: .bottom, fullWidth: fullWidth, cornerRadius: cr, title: noteTitle, message: noteMessage)
            } else if roundCorners && hasImage {
                notifyView = DGNotifyViewRoundedWithImg(fromSide: .bottom, fullWidth: fullWidth, cornerRadius: cr, title: noteTitle, message: noteMessage, img: DemoImage.imageOfDemoImg)
            } else if !roundCorners && !hasImage {
                notifyView = DGNotifyView(fromSide: .bottom, fullWidth: fullWidth, title: noteTitle, message: noteMessage)
            } else {
                notifyView = DGNotifyViewWithImg(fromSide: .bottom, fullWidth: fullWidth, title: noteTitle, message: noteMessage, img: DemoImage.imageOfDemoImg)
            }
        default:
            if roundCorners && !hasImage {
                notifyView = DGNotifyViewRounded(fromSide: .bottomRight, fullWidth: fullWidth, cornerRadius: cr, title: noteTitle, message: noteMessage)
            } else if roundCorners && hasImage {
                notifyView = DGNotifyViewRoundedWithImg(fromSide: .bottomRight, fullWidth: fullWidth, cornerRadius: cr, title: noteTitle, message: noteMessage, img: DemoImage.imageOfDemoImg)
            } else if !roundCorners && !hasImage {
                notifyView = DGNotifyView(fromSide: .bottomRight, fullWidth: fullWidth, title: noteTitle, message: noteMessage)
            } else {
                notifyView = DGNotifyViewWithImg(fromSide: .bottomRight, fullWidth: fullWidth, title: noteTitle, message: noteMessage, img: DemoImage.imageOfDemoImg)
            }
        }
        
        self.view.addSubview(notifyView!)
        notifyView.set(txtColor: UIColor.red, bgColor: UIColor.black)
        notifyView.displayFor(seconds: displaySeconds!) { (finished) in
            if finished {
                self.nilNotifyView()
                sender.isEnabled = true
            }
        }
    }
    
    @IBAction func secondSliderMoved(_ sender: UISlider) {
        displaySeconds = roundedOffSlider(value: sender.value)
    }

}

