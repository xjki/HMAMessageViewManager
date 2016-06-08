#import "HMAMessageViewManager.h"


@interface HMAMessageViewManager()

@property (nonatomic, strong) NSMutableArray<HMAMessageView *> *messages;

@end


@implementation HMAMessageViewManager

#pragma mark Private methods

- (nullable instancetype) init {
    if (self = [super init]) {
        _messages = [NSMutableArray new];
    }
    return self;
}

- (nullable HMAMessageView *) currentMessageForHostingView:(nonnull UIView *)pHostingView {
    HMAMessageView *message = nil;
    for (UIView *subview in [pHostingView subviews]) {
        if ([subview isMemberOfClass:[HMAMessageView class]]) {
            message = (HMAMessageView *)subview;
            break;
        }
    }
    return message;
}


#pragma mark Public methods

+ (nullable instancetype) sharedManager {
    static HMAMessageViewManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[HMAMessageViewManager alloc] init];
    });
    return sharedManager;
}


- (nullable HMAMessageView *) showMessageInController:(nonnull UIViewController *)pController
                                                title:(nonnull NSString *)pTitle
                                             subtitle:(nullable NSString *)pSubtitle
                                                 type:(HMAMessageViewType)pType
{
    @synchronized(self) {
        // for UITableViewController use navigation controller for displaying message
        UIView *hostingView = ([pController isKindOfClass:[UITableViewController class]]) ? pController.navigationController.view : pController.view;
        UIToolbar *toolbar = pController.navigationController.toolbar;
        HMAMessageView *message = [[HMAMessageView alloc] initWithTitle:pTitle
                                                               subtitle:pSubtitle
                                                                   type:pType
                                                                 inView:hostingView
                                                                toolbar:toolbar
                                                       tabBarController:pController.tabBarController];
        [self.messages addObject:message];
        dispatch_async(dispatch_get_main_queue(), ^{
            HMAMessageView *existingMessage = [self currentMessageForHostingView:hostingView];
            if (existingMessage) {
                if (existingMessage.isActiveMessage) {
                    [existingMessage hideMessage];
                }
            }
            [message showMessage];
        });
        return message;
    }
}


- (void) messageViewDidHide:(HMAMessageView *)pMessage {
    @synchronized(self) {
        [self.messages removeObject:pMessage];
    }
}


- (void) hideAllMessages {
    @synchronized(self) {
        dispatch_async(dispatch_get_main_queue(), ^{
            for (HMAMessageView *message in self.messages) {
                if (message.isActiveMessage) {
                    [message hideMessage];
                }
            };
        });
    }
}


@end
