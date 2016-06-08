//
//  HMAMessageView.h - Notification messages used by HMAMessageViewManager
//
//  Copyright © 2016 Jurgis Kirsakmens. All rights reserved.
//

@import UIKit;


typedef NS_ENUM(NSInteger, HMAMessageViewType) {
    HMAMessageViewTypeMessage = 0,
    HMAMessageViewTypeWarning,
    HMAMessageViewTypeError,
    HMAMessageViewTypeSuccess
};


@interface HMAMessageView : UIView

@property (nonatomic, strong, nullable) UIFont *titleFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong, nullable) UIFont *subtitleFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong, nullable) NSNumber *hideMessagesAfterSeconds UI_APPEARANCE_SELECTOR;

/// Returns YES if message is currently visible on screen
@property (nonatomic, readonly) BOOL isActiveMessage;

/// Inits message to be shown (using show method) in hosting view
- (nullable instancetype) initWithTitle:(nonnull NSString *)pTitle
                               subtitle:(nullable NSString *)pSubtitle
                                   type:(HMAMessageViewType)pType
                                 inView:(nonnull UIView *)pHostingView
                                toolbar:(nullable UIToolbar *)pToolbar
                       tabBarController:(nullable UITabBarController *)pTabBarController;

/// Show message by adding to hosting view and then animating from bottom, authides in seconds defined in kMessageViewDismissInSeconds
- (void) showMessage;

/// Hides message by animating to bottom, then removing from hosting view and informing HMAMessageViewManager to remove itself from managed messages
- (void) hideMessage;

@end
