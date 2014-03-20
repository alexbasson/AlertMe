#import "ViewController.h"
#import "APBAlertView.h"

@interface ViewController () <UIAlertViewDelegate>
@property (nonatomic, weak, readwrite) IBOutlet UIButton *button;
@property (nonatomic, weak, readwrite) IBOutlet UILabel *label;
@end

@implementation ViewController

- (IBAction)buttonTapped:(id)sender {
    APBAlertView *alertView = [[APBAlertView alloc] initWithTitle:@"Alert!"
                                                          message:@"Tap a response"
                                                cancelButtonTitle:@"Cancel"
                                                otherButtonTitles:@[@"Choice 1", @"Choice 2"]
                                                    cancelHandler:^{
                                                        self.label.text = @"You tapped 'Cancel'";
                                                    }
                                              confirmationHandler:^(NSInteger otherButtonIndex) {
                                                  switch (otherButtonIndex) {
                                                      case 0:
                                                          self.label.text = @"You tapped 'Choice 1'";
                                                          break;
                                                      case 1:
                                                          self.label.text = @"You tapped 'Choice 2'";
                                                          break;
                                                      default:
                                                          break;
                                                  }
                                              }];
    [alertView show];
}

@end
