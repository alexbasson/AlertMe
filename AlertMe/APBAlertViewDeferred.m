#import "APBAlertViewDeferred.h"
#import "KSDeferred.h"

@interface APBAlertViewDeferred () <UIAlertViewDelegate>
@property (nonatomic, strong) KSDeferred *deferred;
@end

@implementation APBAlertViewDeferred

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles {
    if (self = [super initWithTitle:title
                            message:message
                           delegate:self
                  cancelButtonTitle:cancelButtonTitle
                  otherButtonTitles:nil]) {
        for (NSString *title in otherButtonTitles) {
            [self addButtonWithTitle:title];
        }
    }
    return self;
}

- (KSPromise *)showAlert {
    self.deferred = [KSDeferred defer];
    [self show];
    return self.deferred.promise;
}

#pragma mark - <UIAlertViewDelegate>

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == alertView.cancelButtonIndex) {
        [self.deferred rejectWithError:nil];
    } else {
        NSInteger indexOffset = (alertView.cancelButtonIndex==-1) ? 0 : 1;
        [self.deferred resolveWithValue:@(buttonIndex - indexOffset)];
    }
}

@end
