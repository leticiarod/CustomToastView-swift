# CustomToastView-swift

[![CI Status](https://img.shields.io/travis/lrodriguez@codigodelsur.com/CustomToastView-swift.svg?style=flat)](https://travis-ci.org/lrodriguez@codigodelsur.com/CustomToastView-swift)
[![Version](https://img.shields.io/cocoapods/v/CustomToastView-swift.svg?style=flat)](https://cocoapods.org/pods/CustomToastView-swift)
[![License](https://img.shields.io/cocoapods/l/CustomToastView-swift.svg?style=flat)](https://cocoapods.org/pods/CustomToastView-swift)
[![Platform](https://img.shields.io/cocoapods/p/CustomToastView-swift.svg?style=flat)](https://cocoapods.org/pods/CustomToastView-swift)

A fully customizable library to easily display Animated Toast Messages in iOS using Swift!

## Preview - All the custom toasts you can build!

![](libraryUsage.gif)

## Requirements

## Installation

CustomToastView-swift is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CustomToastView-swift'
```

## Usage

In order to build your custom toast you need to use the Toast builder class. 
The following example shows a Custom Toast on a View Controller class with the default style and animating the Toast with a default animation from bottom to top.

```swift
Toast.Builder()
     .build()
     .show(on: self)
```

#### Animation Types
You can present your Toast messages in different ways:
 - from bottom to top (`.bottomToTop`)
 - from top to bottom (`.topToBottom`)
 - from left to right (`.leftToRight`)
 - from right to left (`.rightToLeft`)
 - fading in (`.fadeIn`)
 - fading out (`.fadeOut`)
    
The only thing you need to do is to specify the orientation (Animation type) when building your toast, as follows:

```swift
Toast.Builder()
     .build()
     .orientation(.leftToRight)
     .show(on: self)
```

#### Specifying Vertical position 

In order to set the `y` position in which the Toast should display we use the `.verticalPosition` property and set the Int value you want, as follows:

```swift
Toast.Builder()
     .build()
     .verticalPosition(150)
     .show(on: self)
```

#### Toast Height 

You might want to change the defautl toast Height the toast has. In case you'd need to that you can do it as follows:
```swift
Toast.Builder()
     .toastHeight(100)
     .build()
     .show(on: self)
```

#### Toast - BackgroundColor, textColor, Font, Title, cornerRadius, textAlignment

#### You can also show action on the Toast

picture 

To do that you just need to set the following properties when building your custom toast!

```swift
Toast.Builder()
     .build()
     .rightActionText("UNDO")
     .show(on: self)
```

You can also set the specific styles for the action:

```swift
Toast.Builder()
     .rightActionText("UNDO")
     .actionFont(UIFont.systemFont(ofSize: 12, weight: .medium))
     .actionTextColor(.white)
     .build()
     .show(on: self)
```

You might want to add anaction completion to the above 'UNDO' action :) You can do that as following:

```swift
Toast.Builder()
     .rightActionText("UNDO")
     .actionFont(UIFont.systemFont(ofSize: 12, weight: .medium))
     .actionTextColor(.white)
     .build()
     .show(on: self, actionCompletion: {
          print("UNDO action tapped")
     })
```

#### Left Icon & letIconContentMode

// TODO

#### Default Distance

This property allows you to change the lateral margins of your toast. If you increase this value the width of the toast will decrease. You can set this as following:

```swift
Toast.Builder()
     .defaultDistance(30)
     .build()
     .show(on: self)
```

#### Time Dismissal

// TODO

#### Should Dismiss After Presenting

// TODO 

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Author

lrodriguez, leticiamrgs@gmail.com

## License

CustomToastView-swift is available under the MIT license. See the LICENSE file for more info.
