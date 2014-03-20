#import <UIKit/UIKit.h>

@class KSPromise;

@interface APBAlertViewDeferred : UIAlertView

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles;

- (KSPromise *)showAlert;

@end
