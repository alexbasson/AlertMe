#import "ViewController.h"
#import "UIControl+Spec.h"
#import "UIAlertView+Spec.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ViewControllerSpec)

describe(@"ViewController", ^{
    __block ViewController *controller;

    beforeEach(^{
        controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController"];
        controller.view should_not be_nil;
    });
    
    describe(@"tapping the button", ^{
        beforeEach(^{
            [controller.button tap];
        });
        
        it(@"should show an alert view", ^{
            UIAlertView *alertView = [UIAlertView currentAlertView];
            alertView should_not be_nil;
            alertView.title = @"Alert!";
            alertView.message = @"Tap a response";
        });
    });
    
    describe(@"responding to the alert view", ^{
        __block UIAlertView *alertView;
        
        beforeEach(^{
            [controller.button tap];
            alertView = [UIAlertView currentAlertView];
            alertView should_not be_nil;
        });
        
        context(@"tapping 'Cancel'", ^{
            beforeEach(^{
                [alertView dismissWithCancelButton];
            });
            
            it(@"should update the label", ^{
                controller.label.text should equal(@"You tapped 'Cancel'");
            });
        });
        
        context(@"tapping 'Choice 1'", ^{
            beforeEach(^{
                [alertView dismissWithClickedButtonIndex:1 animated:NO];
            });
            
            it(@"should update the label", ^{
                controller.label.text should equal(@"You tapped 'Choice 1'");
            });
        });
        
        context(@"tapping 'Choice 2'", ^{
            beforeEach(^{
                [alertView dismissWithClickedButtonIndex:2 animated:NO];
            });
            
            it(@"should update the label", ^{
                controller.label.text should equal(@"You tapped 'Choice 2'");
            });
        });
    });
});

SPEC_END
