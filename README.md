# DGNotifyView

[![CI Status](http://img.shields.io/travis/glowcap/DGNotifyView.svg?style=flat)](https://travis-ci.org/glowcap/DGNotifyView)
[![Version](https://img.shields.io/cocoapods/v/DGNotifyView.svg?style=flat)](http://cocoapods.org/pods/DGNotifyView)
[![License](https://img.shields.io/cocoapods/l/DGNotifyView.svg?style=flat)](http://cocoapods.org/pods/DGNotifyView)
[![Platform](https://img.shields.io/cocoapods/p/DGNotifyView.svg?style=flat)](http://cocoapods.org/pods/DGNotifyView)

DGNotifyView is a Swift-based API that allows quick in-app notification views. The notification views can include images, have rounded corners, and best of all there preprogrammed with animations to slide in to six different locations. You can even set the notification’s display duration!

## Example
To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
You need to import UIKit...obviously. ;)

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

DGNotifyView - This is the basic notification view with square edges
DGNotifyViewWithImg - This allows you to add an image to the basic notification
DGNotifyViewRounded - This is a basic notification view with rounded edges
DGNotifyViewRoundedWithImg - Yep. It’s a rounded notification view with image support.

Since DGNotifyView is based on UIView, you’ll need to ‘import UIKit’ where you are initializing DGNotifyView. Then import DGNotifyView:

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
Once you have an instance of DGNotifyView, you can call it to come in and also how long to display it. This function ends with a closure incase you want to do something when the animation is completed:

```swift
myNotif.displayFor(seconds: 1.0) { (finished) in
            if finished {
               // your code here
            }
        }
```

## To-Do List
There are a few things I’d like to add in the future:

- [ ] Set custom colors for text and view background
- [ ] Set custom font
- [ ] Spring animation option

## Contributing
If your interested in contributing:

1. Fork it.
2. Create your feature branch `git checkout -b new-feature`
3. Commit your changes `git commit -am ‘Added new-feature`
4. Push to the branch `git push origin new-feature`
5. Create a new Pull Request

## Author

glowcap, doku005@yahoo.com

## License

DGNotifyView is available under the MIT license. See the LICENSE file for more info.
