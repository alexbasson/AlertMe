#import "ViewController.h"
#import "APBAlertView.h"
#import "APBAlertViewDeferred.h"
#import "KSDeferred.h"

@interface ViewController () <UIAlertViewDelegate>
@property (nonatomic, weak, readwrite) IBOutlet UIButton *button;
@property (nonatomic, weak, readwrite) IBOutlet UILabel *label;
@property (nonatomic, strong) APBAlertViewDeferred *alertView;
@end

@implementation ViewController

- (IBAction)buttonTapped:(id)sender {
    self.alertView = [[APBAlertViewDeferred alloc] initWithTitle:@"Alert!"
                                                         message:@"Tap a response"
                                               cancelButtonTitle:@"Cancel"
                                               otherButtonTitles:@[@"Choice 1", @"Choice 2"]];
    [[self.alertView showAlert] then:^id(NSNumber *buttonIndex) {
        switch (buttonIndex.integerValue) {
            case 0:
                self.label.text = @"You tapped 'Choice 1'";
                break;
            case 1:
                self.label.text = @"You tapped 'Choice 2'";
                break;
            default:
                break;
        }
        return nil;
    } error:^id(NSError *error) {
        self.label.text = @"You tapped 'Cancel'";
        return nil;
    }];
}

@end
