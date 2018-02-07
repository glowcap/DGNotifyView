# DGNotifyView

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/d7a02042cd26417fb234086cb723a2d0)](https://www.codacy.com/app/daymeing/DGNotifyView?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=glowcap/DGNotifyView&amp;utm_campaign=Badge_Grade)
[![Swift](https://img.shields.io/badge/%20compatible-swift%203.0-orange.svg)](http://swift.org)
[![Version](https://img.shields.io/cocoapods/v/DGNotifyView.svg?style=flat)](http://cocoapods.org/pods/DGNotifyView)
[![License](https://img.shields.io/cocoapods/l/DGNotifyView.svg?style=flat)](http://cocoapods.org/pods/DGNotifyView)
[![Platform](https://img.shields.io/cocoapods/p/DGNotifyView.svg?style=flat)](http://cocoapods.org/pods/DGNotifyView)

DGNotifyView is a Swift-based API that allows quick in-app notification views. The notification views can include images, have rounded corners, and best of all there preprogrammed with animations to slide (or spring!) into six different locations. You can even set the notification’s display duration!

![Screenshot](https://cloud.githubusercontent.com/assets/10408147/22461391/6da12fa0-e7ec-11e6-9209-8fd1e15d05da.png)

## Example
To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
You need to import `UIKit`...obviously. ;)

## Installation
DGNotifyView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "DGNotifyView"
```
### Static Library (manual)
If you prefer to install it manually, copy the files under the DGNotifyView subdirectory into your project. If your application is written in Swift, there’s no need for a bridging header. 

## Usage
DGNotifyView gives you four options for notifications:

- DGNotifyView: This is the basic notification view with square edges
- DGNotifyViewWithImg: This allows you to add an image to the basic notification
- DGNotifyViewRounded: This is a basic notification view with rounded edges
- DGNotifyViewRoundedWithImg: Yep. It’s a rounded notification view with image support.

Now with Springy Views! These are the same as above but use a spring animation to come into view:

- DGNotifyViewSpringy
- DGNotifyViewSpringyImg
- DGNotifyViewRoundedSpringy
- DGNotifyViewRoundedImgSpringy

#### Initializing
Since DGNotifyView is based on UIView, you’ll need to `import UIKit` where you are initializing DGNotifyView. Then:

```swift
import DGNotifyView
```
To add a notification, create an instance of your preferred view with the required information and where you want the view to appear from:

```swift
let myNotif = DGNotifyView(fromSide: .top, fullWidth: false, 
                           title: “My Title”, message: “Important message”)
```
Don’t forget to add it to your view when you’re ready to use it:

```swift
self.view.addSubview(myNotif)
```

#### Customizing
You can change the defalut color of the text and background by calling `set(txtColor: UIColor?, bgColor: UIColor?)`
(setting a parameter to `nil` leaves it the default color:

```swift
myNotif.set(txtColor: UIColor.red, bgColor: UIColor.darkGray)
```

#### Animating
Once you have an instance of DGNotifyView, you can call it to slide in with how long it should be displayed. This function ends with a closure in case you want to do something after the animation is completed:

```swift
myNotif.displayFor(seconds: 1.0) { (finished) in
            if finished {
               // your code here
            }
        }
```

## To-Do List
There are a few things I’d like to add in the future:
- [ ] ~~Add ability to set custom colors for text and background~~
- [ ] Set custom font
- [ ] ~~Spring animation option~~
- [ ] Swipe out of view

## Contributing
If your interested in contributing:

1. Fork it.
2. Create your feature branch `git checkout -b new-feature`
3. Commit your changes `git commit -am ‘Added new-feature`
4. Push to the branch `git push origin new-feature`
5. Create a new Pull Request

## Author

glowcap, [@DaymeinG](https://twitter.com/DaymeinG)

## License

DGNotifyView is available under the MIT license. See the LICENSE file for more info.
