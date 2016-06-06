#import "HMAMessageView.h"
#import "HMAMessageViewManager.h"


/// RGB color macro for using with hex values
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0f \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0f \
blue:((float)(rgbValue & 0xFF))/255.0f alpha:1.0f]


@interface HMAMessageView()

@property (nonatomic, weak) UIView *hostingView;
@property (nonatomic, strong) NSLayoutConstraint *bottomPositionConstraint;
@property (nonatomic) BOOL isHiding;
@property (nonatomic, readwrite) BOOL isActiveMessage;
@property (nonatomic) CGFloat bottomConstraintExtraConstantIfTabbar;
@end


@implementation HMAMessageView

static const int kMessageViewHeight = 80;
static const int kMessageViewDismissInSeconds = 3;
static NSString *const kMessageTitleFontName =  @"AvenirNext-Medium";
static NSString *const kMessageSubtitleFontName = @"AvenirNext-Regular";


#pragma mark - Private methods

+ (UIColor *) backgroundColorForType:(HMAMessageViewType)pType {
    switch (pType) {
        case HMAMessageViewTypeError:
            return UIColorFromRGB(0xDD3B41);
        case HMAMessageViewTypeWarning:
            return UIColorFromRGB(0xDAC43C);
        case HMAMessageViewTypeSuccess:
            return UIColorFromRGB(0x76CF67);
        case HMAMessageViewTypeMessage:
            return UIColorFromRGB(0xD4DDDF);
    }
}


- (nonnull UIFont *) messageTitleFont {
    return ([[HMAMessageView appearance] titleFont]) ? [[HMAMessageView appearance] titleFont]
                                                     : [UIFont fontWithName:kMessageTitleFontName size:14.0f];
}

- (nonnull UIFont *) messageSubtitleFont {
    return ([[HMAMessageView appearance] subtitleFont]) ? [[HMAMessageView appearance] subtitleFont]
                                                        : [UIFont fontWithName:kMessageSubtitleFontName size:12.0f];
}


#pragma mark - Public methods

- (instancetype) initWithTitle:(NSString *)pTitle
                      subtitle:(NSString *)pSubtitle
                          type:(HMAMessageViewType)pType
                        inView:(UIView *)pHostingView
                       toolbar:(UIToolbar *)pToolbar
                        tabBarController:(UITabBarController *)pTabBarController
{
    CGRect frame = CGRectMake(0, pHostingView.frame.size.height, pHostingView.frame.size.width, kMessageViewHeight);
    if (self = [super initWithFrame:frame]) {
        _hostingView = pHostingView;
        _isActiveMessage = NO;
        _bottomConstraintExtraConstantIfTabbar = (pTabBarController && !pTabBarController.tabBar.isHidden) ? pTabBarController.tabBar.frame.size.height : 0;
        if (pToolbar && !pToolbar.hidden && pToolbar.barPosition == UIBarPositionBottom) {
            _bottomConstraintExtraConstantIfTabbar = _bottomConstraintExtraConstantIfTabbar + pToolbar.frame.size.height;
        }
        // message view
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundColor = [HMAMessageView backgroundColorForType:pType];
        [self setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMessage)];
        [self addGestureRecognizer:tapRecognizer];

        // title label
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, frame.size.width-16, frame.size.height-16)];
        titleLabel.text = pTitle;
        titleLabel.font = [self messageTitleFont];
        titleLabel.numberOfLines = 0;
        titleLabel.minimumScaleFactor = 0.5f;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:titleLabel];
        if (!pSubtitle || [pSubtitle isEqualToString:@""]) {
            NSDictionary *views = @{@"title" : titleLabel};
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[title]-8-|" options:0 metrics:nil views:views]];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[title]-8-|" options:0 metrics:nil views:views]];
        }
        else {
            // has subtitle label
            UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, frame.size.width-16, frame.size.height-16)];
            subtitleLabel.text = pSubtitle;
            subtitleLabel.font = [self messageSubtitleFont];
            subtitleLabel.numberOfLines = 0;
            subtitleLabel.minimumScaleFactor = 0.5f;
            subtitleLabel.textAlignment = NSTextAlignmentCenter;
            subtitleLabel.textColor = [UIColor blackColor];
            subtitleLabel.backgroundColor = [UIColor clearColor];
            subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
            [self addSubview:subtitleLabel];
            NSDictionary *views = @{@"title" : titleLabel, @"subtitle" : subtitleLabel};
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[title]-8-|" options:0 metrics:nil views:views]];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[subtitle]-8-|" options:0 metrics:nil views:views]];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[title]-4-[subtitle]-8-|" options:0 metrics:nil views:views]];
        }
    }
    return self;
}


- (void) showMessage {
    if (!self.hostingView || self.isActiveMessage) {
        return;
    }
    if (![self isDescendantOfView:self.hostingView]) {
        // set attributes and constraints for message (before showing)
        self.alpha = 0;
        [self.hostingView addSubview:self];
        [self.hostingView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[message]-0-|" options:0 metrics:nil views:@{@"message" : self}]];
        [self.hostingView addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                                                                    multiplier:1.0 constant:self.frame.size.height]];
        self.bottomPositionConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.hostingView attribute:NSLayoutAttributeBottom
                                                                    multiplier:1.0 constant:self.frame.size.height - self.bottomConstraintExtraConstantIfTabbar];
        [self.hostingView addConstraint:self.bottomPositionConstraint];
        [self layoutIfNeeded];
    }

    // set attributes/constraints for showing animation
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:.5f initialSpringVelocity:0.5f options:0 animations:^{
        self.bottomPositionConstraint.constant = 0 - self.bottomConstraintExtraConstantIfTabbar;
        self.alpha = 0.9f;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, kMessageViewDismissInSeconds * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self hideMessage];
        });
    }];
    self.isActiveMessage = YES;
}


- (void) hideMessage {
    if (!self.hostingView || self.isHiding) {
        return;
    }
    self.isHiding = YES;
    [UIView animateWithDuration:0.3f animations:^{
        self.bottomPositionConstraint.constant = self.frame.size.height - self.bottomConstraintExtraConstantIfTabbar;
        self.alpha = 0;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.isActiveMessage = NO;
        self.isHiding = NO;
        self.hostingView = nil;
        [[HMAMessageViewManager sharedManager] messageViewDidHide:self];
    }];
}


@end
