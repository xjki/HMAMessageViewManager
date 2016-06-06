#import "HMAMessageView.h"
#import "HMAMessageViewManager.h"
@import XCTest;

@interface HMAMessageViewManagerTests : XCTestCase

@property UIViewController *controller;
@property UIView *view;

@end


@implementation HMAMessageViewManagerTests

- (void) setUp {
    [super setUp];
    self.controller = [UIViewController new];
    self.view = self.controller.view;
    self.view.frame = CGRectMake(0,0, 320, 480);
}


- (void) tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void) test_sharedManager {
    // given
    HMAMessageViewManager *manager = [HMAMessageViewManager sharedManager];
    XCTAssertNotNil(manager, @"Message is not nil");

    // when
    HMAMessageViewManager *anotherManager = [HMAMessageViewManager sharedManager];

    // then
    XCTAssertEqualObjects(manager, anotherManager);
}


- (void) test_showMessage {
    // given
    HMAMessageViewManager *manager = [HMAMessageViewManager sharedManager];

    // when
    HMAMessageView *message = [manager showMessageInController:self.controller title:@"Title" subtitle:@"subTitle" type:HMAMessageViewTypeError];

    // then (after short pause because messages are dispatched to main thread async block)
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
    XCTAssertTrue([[self.view subviews] containsObject:message], @"Message is not in the view hieirachy");
}


- (void) test_showMessage_hidesOtherMessage {
    // given
    HMAMessageViewManager *manager = [HMAMessageViewManager sharedManager];

    // when
    HMAMessageView *message = [manager showMessageInController:self.controller title:@"Title" subtitle:@"subTitle" type:HMAMessageViewTypeError];
    HMAMessageView *anotherMessage = [manager showMessageInController:self.controller title:@"Other title" subtitle:@"subTitle" type:HMAMessageViewTypeError];

    // then  (after short pause because messages are dispatched to main thread async block)
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
    XCTAssertFalse([[self.view subviews] containsObject:message], @"Message is not in the view hieirachy");
    XCTAssertTrue([[self.view subviews] containsObject:anotherMessage], @"Message is not in the view hieirachy");
}


- (void) test_hideAllMessages {
    // given
    UIViewController *anotherController = [UIViewController new];
    anotherController.view.frame = CGRectMake(0, 0, 200, 300);
    HMAMessageViewManager *manager = [HMAMessageViewManager sharedManager];
    HMAMessageView *message = [manager showMessageInController:self.controller title:@"Title" subtitle:@"subTitle" type:HMAMessageViewTypeError];
    HMAMessageView *anotherMessage = [manager showMessageInController:anotherController title:@"Other title" subtitle:@"subTitle" type:HMAMessageViewTypeError];

    // when
    [manager hideAllMessages];

    // then - after animation finishes
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.3]];
    XCTAssertFalse([[self.view subviews] containsObject:message], @"Message is not removed from view hieirachy after 0.3 seconds (animation time)");
    XCTAssertFalse([[anotherController.view subviews] containsObject:anotherMessage], @"Message is not removed from view hieirachy after 0.3 seconds (animation time)");
}


@end

