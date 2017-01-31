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
    
    // I'm calling the top-level class because this app is using
    // a variety of notifications for the demo. If you're
    // using a single type, just initiate that one ex: 'myNote: DGNotifyView!'
    var notifyView: DGNotificationView!
    
    // This variable is put here because this app is
    // demoing all sides, you probably won't need to do this.
    var side: DGNotificationView.Side!
    
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
    @IBOutlet weak var topSegment: UISegmentedControl!
    @IBOutlet weak var bottomSegment: UISegmentedControl!
    
    // This is only for the demo app
    // It's used in sendNotifTapped
    var selectedDirection: Bool {
        guard (topSegment != nil || bottomSegment != nil) else { return false }
        guard (topSegment.selectedSegmentIndex >= 0 || bottomSegment.selectedSegmentIndex >= 0) else { return false }
        return true
    }
    
    let noteTitle = "Sample Notification"
    let noteMessage = "This message can contain up to 3 lines of text. The text is required on initialization. Once initialized you can call the view to slide in from one of six locations."

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displaySeconds = roundedOffSlider(value: secondSlider.value)
        
    }
    
    
    func toggleSeg(selected: UISegmentedControl) {
        guard topSegment != nil , bottomSegment != nil else { return }
        let off = -1
        if selected == topSegment {
            bottomSegment.selectedSegmentIndex = off
        } else {
            topSegment.selectedSegmentIndex = off
        }
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
    
    
    // ********
    // The way notifyView is being called is a bit strange
    // since I'm demoing every type of DGNotifyView presented from
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
    // ********
    private func createNotification() {
        guard side != nil else { return }
        let img = DemoImage.imageOfDemoImg
        let roundCorners = rCornersSwitch.isOn
        let hasImage  = imgSwitch.isOn
        let fullWidth = fullWidthSwitch.isOn
        let cr:CGFloat = 5.0
        
        
        if roundCorners {
            if hasImage {
                notifyView = DGNotifyViewRoundedWithImg(fromSide: side, fullWidth: fullWidth, cornerRadius: cr,
                                                        title: noteTitle, message: noteMessage, img: img)
                return
            }
            notifyView = DGNotifyViewRounded(fromSide: side, fullWidth: fullWidth, cornerRadius: cr,
                                             title: noteTitle, message: noteMessage)
        } else {
            if hasImage {
                notifyView = DGNotifyViewWithImg(fromSide: side, fullWidth: fullWidth,
                                                 title: noteTitle, message: noteMessage, img: img)
                return
            }
            
            notifyView = DGNotifyView(fromSide: side, fullWidth: fullWidth,
                                      title: noteTitle, message: noteMessage)
        }
    }

    
    @IBAction func NotifSegTapped(_ sender: UISegmentedControl) {
        toggleSeg(selected: sender)
        
        let location = (sender.tag, sender.selectedSegmentIndex)
        switch location {
        case (0,0):
            print("print case")
            side = .topLeft
        case (0,1):
            side = .top
        case (0,2):
            side = .topRight
        case (1,0):
            side = .bottomLeft
        case (1,1):
            side = .bottom
        case (1,2):
            side = .bottomRight
        default:
            print("you should be here")
            side = .top
        }
    }
    
    
    @IBAction func sendNotifTapped(_ sender: UIButton) {
        guard selectedDirection else { return }
        createNotification()
        view.addSubview(notifyView)
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

