# HMAMessageViewManager

[![CI Status](http://img.shields.io/travis/xjki/HMAMessageViewManager.svg?style=flat)](https://travis-ci.org/xjki/HMAMessageViewManager)
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

Message banner hides automatically after seconds you can define via appearance proxy (default is 3 seconds) or by user tap.


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
    [[HMAMessageViewManager sharedManager] showMessageInController:self title:NSLocalizedString(@"Ooops!", @"Warning title for invalid data") subtitle:pTitle type:HMAMessageViewTypeWarning];
}

@end
```

and then just use

```objective-c
[myController my_showWarningMessage:@"Wrong email address"];
```

## Customization

To customize font/font size for message title/subtitle and message auto-hide time in you app delegate (or any other place setting default appearance):

```objective-c
#import "HMAMessageView.h"
...
[[HMAMessageView appearance] setTitleFont:[UIFont boldSystemFontOfSize:12]];
[[HMAMessageView appearance] setSubtitleFont:[UIFont boldSystemFontOfSize:7]];
[[HMAMessageView appearance] setHideMessagesAfterSeconds:@4];
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Requirements

Xcode9, iOS11 SDK, supports iOS 10.0 and higher


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

