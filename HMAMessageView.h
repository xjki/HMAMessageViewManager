//
//  HMAMessageView.h - Notification messages used by HMAMessageViewManager
//
//  Created by Jurgis Kirsakmens on 19.11.15.
//  Copyright © 2015 Jurgis Kirsakmens. All rights reserved.
//

@import UIKit;


typedef NS_ENUM(NSInteger, HMAMessageViewType) {
    HMAMessageViewTypeMessage = 0,
    HMAMessageViewTypeWarning,
    HMAMessageViewTypeError,
    HMAMessageViewTypeSuccess
};


@interface HMAMessageView : UIView

@property (nonatomic,strong, nullable) UIFont *titleFont UI_APPEARANCE_SELECTOR;
@property (nonatomic,strong, nullable) UIFont *subtitleFont UI_APPEARANCE_SELECTOR;

/// Returns YES if message is currently visible on screen
@property (nonatomic, readonly) BOOL isActiveMessage;

/// Returns message to be shown (using show method) in hosting view
- (nullable instancetype) initWithTitle:(nonnull NSString *)pTitle
                               subtitle:(nullable NSString *)pSubtitle
                                   type:(HMAMessageViewType)pType
                                 inView:(nonnull UIView *)pHostingView;

/// Show message by adding to hosting view and then animating from bottom, authodes in seconds defined in kMessageViewDismissInSeconds
- (void) showMessage;

/// Hides message by animating to bottom, then removing from hosting view and informing HMAMessageViewManager to remove itself from managed messages
- (void) hideMessage;

@end
