//
//  YMViewController.m
//  YoMa
//
//  Created by Sumedha Pramod on 7/13/14.
//  Copyright (c) 2014 Sumedha Pramod. All rights reserved.
//

#import "YMViewController.h"
#import "YMTableViewController.h"

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


#pragma mark -
#pragma mark Responding to gestures

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

@end
