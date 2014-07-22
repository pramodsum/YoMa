//
//  YMLoginViewController.h
//  YoMa
//
//  Created by Sumedha Pramod on 7/13/14.
//  Copyright (c) 2014 Sumedha Pramod. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface YMLoginViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;

- (IBAction)signup:(id)sender;
- (IBAction)login:(id)sender;

@end
