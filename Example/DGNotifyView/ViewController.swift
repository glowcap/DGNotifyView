//
//  ViewController.swift
//  DGNotifyView
//
//  Created by glowcap on 01/23/2017.
//  Copyright (c) 2017 glowcap. All rights reserved.
//

import UIKit
import DGNotifyView

final class ViewController: UIViewController {

  private var notifyView: DGNotificationView!
  
  /// This variable is put here because this app is demoing
  /// all directions, you probably won't need to do this.
  private var direction: DGNotificationView.Direction!
  
  private var displaySeconds: Double! {
    didSet {
      secondLabel.text = String(displaySeconds)
    }
  }
  
  @IBOutlet weak var rCornersSwitch: UISwitch!
  @IBOutlet weak var imgSwitch: UISwitch!
  @IBOutlet weak var fullWidthSwitch: UISwitch!
  @IBOutlet weak var animationSeg: UISegmentedControl!
  @IBOutlet weak var secondSlider: UISlider!
  @IBOutlet weak var secondLabel: UILabel!
  @IBOutlet weak var topSegment: UISegmentedControl!
  @IBOutlet weak var bottomSegment: UISegmentedControl!
  
  // This is only for the demo app
  // It's used in sendNotifTapped
  private var selectedDirection: Bool {
    guard topSegment != nil || bottomSegment != nil else { return false }
    guard topSegment.selectedSegmentIndex >= 0 ||
      bottomSegment.selectedSegmentIndex >= 0 else { return false }
    return true
  }
  
  private var isSpringy: Bool {
    guard animationSeg != nil else { return false }
    return animationSeg.selectedSegmentIndex == 1
  }
  
  let noteTitle = "Sample Notification"
  let noteMessage = "This message can contain up to 3 lines of text. The label text are init parameters."
  
  override func viewDidLoad() {
    super.viewDidLoad()
    displaySeconds = roundedOffSlider(value: secondSlider.value)
  }
  
  private func toggleSeg(selected: UISegmentedControl) {
    guard topSegment != nil , bottomSegment != nil else { return }
    let off = -1
    if selected == topSegment {
      bottomSegment.selectedSegmentIndex = off
    } else {
      topSegment.selectedSegmentIndex = off
    }
  }
  
  // Here the instance of DGNotificationView is being recycled
  // so I'm wiping out the exisiting one
  private func nilNotifyView() {
    notifyView.removeFromSuperview()
    notifyView = nil
  }
  
  private func roundedOffSlider(value: Float) -> Double {
    return Double(round(value))
  }
  
  // The way notifyView is being called is a bit strange
  // since every type of DGNotificationView is being demoed.
  // I don't recommend doing it this way.
  //
  
  private func createNotification() {
    guard direction != nil else { return }
    let img = DemoImage.imageOfDemo
    let roundCorners = rCornersSwitch.isOn
    let hasImage  = imgSwitch.isOn
    let fullWidth = fullWidthSwitch.isOn
    let cr:CGFloat = 5.0
    
    if roundCorners {
      if hasImage && isSpringy {
        notifyView = DGNotificationView(title: noteTitle, message: noteMessage,
                                        direction: direction, fullWidth: fullWidth,
                                        cornerRadius: cr, image: img,
                                        useSprings: true)
        return
      } else if hasImage {
        notifyView = DGNotificationView(title: noteTitle, message: noteMessage,
                                        direction: direction, fullWidth: fullWidth,
                                        cornerRadius: cr, image: img)
        return
      } else if !hasImage && isSpringy {
        notifyView = DGNotificationView(title: noteTitle, message: noteMessage,
                                        direction: direction, fullWidth: fullWidth,
                                        cornerRadius: cr, useSprings: true)
        return
      } else {
        notifyView = DGNotificationView(title: noteTitle, message: noteMessage,
                                        direction: direction, fullWidth: fullWidth,
                                        cornerRadius: cr)
        return
      }
      
    } else {
      if hasImage && isSpringy {
        notifyView = DGNotificationView(title: noteTitle, message: noteMessage,
                                        direction: direction, fullWidth: fullWidth,
                                        image: img, useSprings: true)
        return
      } else if hasImage {
        notifyView = DGNotificationView(title: noteTitle, message: noteMessage,
                                        direction: direction, fullWidth: fullWidth,
                                        image: img)
        return
      } else if !hasImage && isSpringy {
        notifyView = DGNotificationView(title: noteTitle, message: noteMessage,
                                        direction: direction, fullWidth: fullWidth,
                                        useSprings: true)
        return
      } else {
        notifyView = DGNotificationView(title: noteTitle, message: noteMessage,
                                        direction: direction, fullWidth: fullWidth)
        return
      }
    }
  }
  
  @IBAction func NotifSegTapped(_ sender: UISegmentedControl) {
    toggleSeg(selected: sender)
    
    let location = (sender.tag, sender.selectedSegmentIndex)
    switch location {
    case (0,0):
      direction = .topLeft
    case (0,1):
      direction = .top
    case (0,2):
      direction = .topRight
    case (1,0):
      direction = .bottomLeft
    case (1,1):
      direction = .bottom
    case (1,2):
      direction = .bottomRight
    default:
      print("you should be here")
      direction = .top
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
