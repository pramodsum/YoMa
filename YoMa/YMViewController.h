//
//  YMViewController.h
//  YoMa
//
//  Created by Sumedha Pramod on 7/13/14.
//  Copyright (c) 2014 Sumedha Pramod. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface YMViewController : UIViewController <UIGestureRecognizerDelegate, MFMessageComposeViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UIButton *YoMa_button;
- (IBAction)send_YoMa:(id)sender;

@end
