# KCCircularTimer

[![CI Status](http://img.shields.io/travis/kcramer/KCCircularTimer.svg?style=flat)](https://travis-ci.com/kcramer/KCCircularTimer)
[![Version](https://img.shields.io/cocoapods/v/KCCircularTimer.svg?style=flat)](http://cocoapods.org/pods/KCCircularTimer)
[![License](https://img.shields.io/cocoapods/l/KCCircularTimer.svg?style=flat)](http://cocoapods.org/pods/KCCircularTimer)
[![Platform](https://img.shields.io/cocoapods/p/KCCircularTimer.svg?style=flat)](http://cocoapods.org/pods/KCCircularTimer)

KCCircularTimer is a simple, configurable circular timer that is usable in Interface Builder in Xcode.

![Sample Screenshot](https://github.com/kcramer/KCCircularTimer/blob/master/Assets/TimerSample.png)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Usage

To create a circular timer, add a UIView to your storyboard and in the Identity Inspector under Custom Class, set Class to KCCircularTimer.  If the view does not show properly, select the Xcode menu item Editor...Refresh All Views.

![Setting the class of the UIView](https://github.com/kcramer/KCCircularTimer/blob/master/Assets/ConfiguringView.png)

## Properties

You can configure the circular timer from the storyboard or in code if you create an outlet for it.  You can configure the following values in the storyboard or code:

* Current Value: Current value of the timer.  Should be between 0 and the maximum value.
* Maximum Value: The maximum value the timer can have.
* Border Factor: Width of the line of the progress circle expressed as a percent of the size.
* Circle Factor: Width of the line of the background circle expressed as a percent of the size.
* Inset Factor: Distance the circle is inset from the edges expressed as a percent of the size.
* Tint Color: Setting tint color will automatically set the progress and circle colors.  See below for customization.
* Progress Color: Color of the progress circle.
* Circle Color: Color of the background circle.
* Circle Alpha: The alpha of the background circle.
* Font Name: Name of the font to use.  Defaults to system font if not specified.
* Font Size: Size of the font to use.  Defaults to a value based on the size of the circle if not specified.
* Clockwise: Does the circle fill clockwise or counter-clockwise? True if you want the timer to count up, otherwise false.
* Show Number: Specifies if the numeric timer should be shown.
* Decimal Places: Number of decimal places to show for the numeric timer.  Possible values are 0, 1, 2.

The line cap for the progress is configurable in code.  You can make it square, butt, or rounded.

If you want to count down or up, just use the animate method:

```Swift
timer.animate(from: 60, to: 0)
```

## Requirements

KCCircularTimer requires iOS 8.0+.

## Installation

KCCircularTimer is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'KCCircularTimer'
```

## Author

Kevin Cramer, kevinx@sent.com

## License

KCCircularTimer is available under the MIT license. See the LICENSE file for more info.
