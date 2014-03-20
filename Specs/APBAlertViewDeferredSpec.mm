#import "APBAlertViewDeferred.h"
#import "UIAlertView+Spec.h"
#import "KSDeferred.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(APBAlertViewDeferredSpec)

describe(@"APBAlertViewDeferred", ^{
    __block APBAlertViewDeferred *alertView;

    beforeEach(^{
        alertView = [[APBAlertViewDeferred alloc] initWithTitle:@"Title" message:@"message" cancelButtonTitle:@"Cancel" otherButtonTitles:@[@"button1", @"button2"]];
    });

    it(@"should create the alert view", ^{
        alertView.title should equal(@"Title");
        alertView.message should equal(@"message");
        [alertView buttonTitleAtIndex:alertView.cancelButtonIndex] should equal(@"Cancel");
        [alertView buttonTitleAtIndex:1] should equal(@"button1");
        [alertView buttonTitleAtIndex:2] should equal(@"button2");
        alertView.delegate should be_same_instance_as(alertView);
    });
    
    describe(@"showing the alert view", ^{
        beforeEach(^{
            [alertView showAlert];
        });
        
        it(@"should show the alert view", ^{
            [UIAlertView currentAlertView] should_not be_nil;
        });
    });
    
    describe(@"pressing buttons", ^{
        __block KSPromise *promise;
        
        beforeEach(^{
            promise = [alertView showAlert];
        });
        
        context(@"cancel button", ^{
            beforeEach(^{
                [alertView dismissWithClickedButtonIndex:alertView.cancelButtonIndex animated:NO];
            });
            
            it(@"should call the cancel handler", ^{
                promise.rejected should be_truthy;
            });
        });
        
        context(@"button1", ^{
            beforeEach(^{
                [alertView dismissWithClickedButtonIndex:1 animated:NO];
            });
            
            it(@"should fulfill the promise with button 1", ^{
                promise.fulfilled should be_truthy;
                promise.value should equal(@0);
            });
        });
        
        context(@"button2", ^{
            beforeEach(^{
                [alertView dismissWithClickedButtonIndex:2 animated:NO];
            });
            
            it(@"should fulfill the promise with button 2", ^{
                promise.fulfilled should be_truthy;
                promise.value should equal(@1);
            });
        });
    });
});

SPEC_END
