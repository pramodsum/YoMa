//
//  YMViewController.m
//  YoMa
//
//  Created by Sumedha Pramod on 7/13/14.
//  Copyright (c) 2014 Sumedha Pramod. All rights reserved.
//

#import "YMViewController.h"
#import "YMTableViewController.h"
#import <Parse/Parse.h>

@interface YMViewController ()

@property (nonatomic, strong) IBOutlet UITapGestureRecognizer *tapRecognizer;
@property (nonatomic, strong) IBOutlet UISwipeGestureRecognizer *swipeRightRecognizer;
@property (nonatomic, strong) IBOutlet UISegmentedControl *segmentedControl;

@end

@implementation YMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:YES];

    UISwipeGestureRecognizer *gestureLeft;
    gestureLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];//need to set direction.
    [gestureLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    //[gesture setNumberOfTouchesRequired:1];//default is 1
    [[self view] addGestureRecognizer:gestureLeft];//this gets things rolling.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {

    // Disallow recognition of tap gestures in the segmented control.
    if (gestureRecognizer == self.tapRecognizer) {
        return NO;
    }
    return YES;
}


#pragma mark - Responding to gestures

/*
 In response to a swipe gesture, show the image view appropriately then move the image view in the direction of the swipe as it fades out.
 */
- (IBAction)showGestureForSwipeRecognizer:(UISwipeGestureRecognizer *)recognizer {
    [self performSegueWithIdentifier:@"show_yomas_segue" sender:self];
}

- (void)swipeLeft:(UISwipeGestureRecognizer *)gesture
{
    NSLog(@"Left Swipe received.");//Lets you know this method was called by gesture recognizer.
    NSLog(@"Direction is: %lu", gesture.direction);//Lets you know the numeric value of the gesture direction for confirmation (1=right).
    //only interested in gesture if gesture state == changed or ended (From Paul Hegarty @ standford U
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded)) {
        [self performSegueWithIdentifier:@"show_yomas_segue" sender:self];
    }
}

- (IBAction)send_YoMa:(id)sender {
    // Create our Installation query
    PFQuery *pushQuery = [PFInstallation query];
    [pushQuery whereKey:@"deviceType" equalTo:@"ios"];

    // Send push notification to query
    [PFPush sendPushMessageToQueryInBackground:pushQuery withMessage:@"YoMa"];

    //SMS Notification until push works
//    [self showSMS];
}

#pragma mark - Messages

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;

        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }

        case MessageComposeResultSent:
            break;

        default:
            break;
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showSMS {

    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }

    NSArray *recipents = @[@"2488777868"];
    NSString *message = [NSString stringWithFormat:@"YoMa!"];

    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setRecipients:recipents];
    [messageController setBody:message];

    // Present message view controller on screen
    [self presentViewController:messageController animated:YES completion:nil];
}

@end
