#import "HMAViewController.h"
#import "HMAMessageViewManager.h"


@implementation HMAViewController

- (IBAction) typeChanged:(UISegmentedControl *)sender {
    HMAMessageViewManager *messageManager = [HMAMessageViewManager sharedManager];
    if (sender.selectedSegmentIndex == 0) {
        [messageManager showMessageInController:self title:@"What a error!" subtitle:@"Nice error you have there" type:HMAMessageViewTypeError];
    }
    else if (sender.selectedSegmentIndex == 1) {
        [messageManager showMessageInController:self title:@"Attention!" subtitle:@"Kinda scary button you pressed" type:HMAMessageViewTypeWarning];
    }
    else if (sender.selectedSegmentIndex == 2) {
        [messageManager showMessageInController:self title:@"Finally!" subtitle:@"This is awesome!" type:HMAMessageViewTypeSuccess];
    }
    else if (sender.selectedSegmentIndex == 3) {
        [messageManager showMessageInController:self title:@"Or just message (with or without subtitle)" subtitle:nil type:HMAMessageViewTypeMessage];
    }
}

@end
