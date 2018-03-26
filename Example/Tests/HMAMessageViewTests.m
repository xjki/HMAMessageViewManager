#import "HMAMessageView.h"
#import "HMAMessageViewManager.h"
@import XCTest;


@interface HMAMessageViewTests : XCTestCase

@property UIView *view;

@end


@implementation HMAMessageViewTests


- (void) setUp {
    [super setUp];
    self.view = [UIView new];
    self.view.frame = CGRectMake(0,0, 320, 480);
}


- (void) tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void) test_showMessageView {
    // given
    HMAMessageView *message = [[HMAMessageView alloc] initWithTitle:@"Title"
                                                           subtitle:@"subtitle"
                                                               type:HMAMessageViewTypeError
                                                             inView:self.view
                                                            toolbar:nil
                                                   tabBarController:nil];
    XCTAssertNotNil(message, @"Message is not nil");

    // when
    [message showMessage];

    // then
    XCTAssertTrue([[self.view subviews] containsObject:message], @"Message is not in the view hieirachy");
}


- (void) test_hideMessageView {
    HMAMessageView *message = [[HMAMessageView alloc] initWithTitle:@"Title"
                                                           subtitle:@"subtitle"
                                                               type:HMAMessageViewTypeError
                                                             inView:self.view
                                                            toolbar:nil
                                                   tabBarController:nil];

    // given
    [message showMessage];

    // when
    [message hideMessage];

    // then - after animation finishes
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.3]];
    XCTAssertFalse([[self.view subviews] containsObject:message], @"Message is not removed from view hierachy after 0.3 seconds (animation time)");
}


- (void) test_autoHideMessageView {
    // given
    HMAMessageView *message = [[HMAMessageView alloc] initWithTitle:@"Title"
                                                           subtitle:@"subtitle"
                                                               type:HMAMessageViewTypeError
                                                             inView:self.view
                                                            toolbar:nil
                                                   tabBarController:nil];
    // when
    [message showMessage];

    // then - after 3 secs + 0.3 sec hide animation
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:3.3]];
    XCTAssertFalse([[self.view subviews] containsObject:message], @"Message is not auto hidden");
}

@end

