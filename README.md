# HMAMessageViewManager

[![CI Status](http://img.shields.io/travis/jki/HMAMessageViewManager.svg?style=flat)](https://travis-ci.org/xjki/HMAMessageViewManager)
[![Version](https://img.shields.io/cocoapods/v/HMAMessageViewManager.svg?style=flat)](http://cocoapods.org/pods/HMAMessageViewManager)
[![License](https://img.shields.io/cocoapods/l/HMAMessageViewManager.svg?style=flat)](http://cocoapods.org/pods/HMAMessageViewManager)
[![Platform](https://img.shields.io/cocoapods/p/HMAMessageViewManager.svg?style=flat)](http://cocoapods.org/pods/HMAMessageViewManager)

Dead simple notification message banners (appearing from bottom) for iOS.

![example mov](https://cloud.githubusercontent.com/assets/747340/11300924/7f996164-8f9b-11e5-9830-9d29793ba143.gif)

* No dependencies
* Rotation support (uses autolayout)
* Error, Warning, Success and Default types
* Customize fonts via UIAppearance
* No legacy code ;)

Message banner hides automatically after seconds defined with kMessageViewDismissInSeconds constant or by user tap.


## Sample Usage

```objective-c
#import "HMAMessageViewManager.h"
...
[[HMAMessageViewManager sharedManager] showMessageInController:self title:@"Oops!" subtitle:@"Did not expected this" type:HMAMessageViewTypeWarning];
```

For convenience you can also add simple UIViewController category class, for  example

```objective-c
#import "UIViewController+HMAMessages.h"
#import "HMAMessageViewManager.h"

@implementation UIViewController (HMAMessages)

- (void) my_showWarningMessage:(NSString *)pTitle {
    [self showMessageWithTitle:NSLocalizedString(@"Ooops!", @"Warning title for invalid data") subtitle:pTitle messageType:HMAMessageViewTypeWarning];
}

@end
```

and then just use

```objective-c
[myController my_showWarningMessage:@"Wrong email address"];
```

## Customization

To customize font/font size for message title and subtitle in you app delegate (or any other place setting default appearance):

```objective-c
#import "HMAMessageView.h"
...
[[HMAMessageView appearance] setTitleFont:[UIFont boldSystemFontOfSize:10]];
[[HMAMessageView appearance] setSubtitleFont:[UIFont boldSystemFontOfSize:6]];
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Requirements

Xcode 7, iOS9 SDK, supports iOS 8.0 and higher


## Installation

HMAMessageViewManager is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "HMAMessageViewManager"
```

## Author

Jurgis Kirsakmens, https://twitter.com/xjki


## License

HMAMessageViewManager is available under the MIT license. See the LICENSE file for more info.
