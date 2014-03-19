#import "ViewController.h"

@interface ViewController () <UIAlertViewDelegate>
@property (nonatomic, weak, readwrite) IBOutlet UIButton *button;
@property (nonatomic, weak, readwrite) IBOutlet UILabel *label;
@end

@implementation ViewController

- (IBAction)buttonTapped:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert!"
                                                        message:@"Tap a response"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Choice 1", @"Choice 2", nil];
    [alertView show];
}

//
// Lots and lots of other code
//

#pragma mark - <UIAlertViewDelegate>

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *labelText;
    switch (buttonIndex) {
        case 0:
            labelText = @"You tapped 'Cancel'";
            break;
        case 1:
            labelText = @"You tapped 'Choice 1'";
            break;
        case 2:
            labelText = @"You tapped 'Choice 2'";
            break;
        default:
            break;
    }
    self.label.text = labelText;
}

@end
