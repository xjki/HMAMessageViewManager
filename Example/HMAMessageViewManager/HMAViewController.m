#import "HMAViewController.h"
#import "HMAMessageViewManager.h"


@implementation HMAViewController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // set custom appearance for message banners
    [[HMAMessageView appearance] setTitleFont:[UIFont boldSystemFontOfSize:16]];
    [[HMAMessageView appearance] setSubtitleFont:[UIFont systemFontOfSize:12]];
    // [[HMAMessageView appearance] setHideMessagesAfterSeconds:@4];
}


- (IBAction) typeChanged:(UISegmentedControl *)sender {
    HMAMessageViewManager *messageManager = [HMAMessageViewManager sharedManager];
    if (sender.selectedSegmentIndex == 0) {
        [messageManager showMessageInController:self title:@"What a error!" subtitle:@"Nice error you have there" type:HMAMessageViewTypeError];
    }
    else if (sender.selectedSegmentIndex == 1) {
        [messageManager showMessageInController:self title:@"Attention!" subtitle:@"Kinda scary button you pressed - I don't even know what to do with this warning..." type:HMAMessageViewTypeWarning];
    }
    else if (sender.selectedSegmentIndex == 2) {
        [messageManager showMessageInController:self title:@"Finally!" subtitle:@"This is awesome!" type:HMAMessageViewTypeSuccess];
    }
    else if (sender.selectedSegmentIndex == 3) {
        [messageManager showMessageInController:self title:@"Or just message (with or without subtitle)" subtitle:nil type:HMAMessageViewTypeMessage];
    }
}

@end
