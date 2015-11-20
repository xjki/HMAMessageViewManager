//
//  HMAMessageViewManager.h - on screen messages banner manager for info/warnings/errors.
//  Design limitations: messages appear from bottom, only one message on the view (showing new message dismisses previous message)
//
//  Created by Jurgis Kirsakmens on 19.11.15.
//  Copyright © 2015 Jurgis Kirsakmens. All rights reserved.
//

@import Foundation;
#import "HMAMessageView.h"


@interface HMAMessageViewManager : NSObject

/// Get HMAMessageViewManager singleton
+ (nullable instancetype) sharedManager;

/// Return message (and hide previously displayed message if any) that will be shown from bottom of the hosting view of the passed controller
/// Message will be hidden by user tapping or it or automatically after seconds defined in kMessageViewDismissInSeconds constant
- (nullable HMAMessageView *) showMessageInController:(nonnull UIViewController *)pController
                                                title:(nonnull NSString *)pTitle
                                             subtitle:(nullable NSString *)pSubtitle
                                                 type:(HMAMessageViewType)pType;

/// Hides all currently displayed messages in all views
- (void) hideAllMessages;

/// Inform manager that message has been hidden to remove it from managed messages list
/// Will be called by HMAMessageView after hiding message (automatically or by user taping on message view)
- (void) messageViewDidHide:(nonnull HMAMessageView *)pMessage;

@end
