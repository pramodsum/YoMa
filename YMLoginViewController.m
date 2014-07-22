//
//  YMLoginViewController.m
//  YoMa
//
//  Created by Sumedha Pramod on 7/13/14.
//  Copyright (c) 2014 Sumedha Pramod. All rights reserved.
//

#import "YMLoginViewController.h"

@interface YMLoginViewController ()

@end

@implementation YMLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:YES];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    if ([PFUser currentUser]) {
        [self performSegueWithIdentifier:@"login_segue" sender:self];
    }

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];

    [self.view addGestureRecognizer:tapGesture];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)signup:(id)sender {
    NSLog(@"user: %@\npassword: %@", _username.text, _password.text);
    // Check if both fields are completed
    if (_username.text.length > 0 && _password.text.length > 0) {
        PFUser *user = [PFUser user];
        user.username = _username.text;
        user.password = _password.text;
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                [self performSegueWithIdentifier:@"login_segue" sender:self];
                return;
            } else {
                NSString *errorString = [error userInfo][@"error"];
                [[[UIAlertView alloc] initWithTitle:@"Signup Fail!" message:errorString delegate:self cancelButtonTitle:@"Um okay..." otherButtonTitles:nil] show];
            }
        }];
    }

    [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                message:@"Make sure you fill out all of the information!"
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];


}

- (IBAction)login:(id)sender {
    // Check if both fields are completed
    if (_username.text.length != 0 && _password.text.length != 0) {
        [PFUser logInWithUsernameInBackground:_username.text password:_password.text
                                        block:^(PFUser *user, NSError *error) {
                                            if (user) {
                                                [self performSegueWithIdentifier:@"login_segue" sender:self];
                                                return;
                                            } else {
                                                [[[UIAlertView alloc] initWithTitle:@"Nope-a-saurus" message:@"" delegate:self cancelButtonTitle:@":(" otherButtonTitles:nil] show];
                                            }
                                        }];
    }

    [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                message:@"Make sure you fill out all of the information!"
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - keyboard movements
- (void)keyboardWillShow:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = -100.0f;  //set the -35.0f to your required value
        self.view.frame = f;
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        self.view.frame = f;
    }];
}

-(void)hideKeyBoard {
    [_username resignFirstResponder];
    [_password resignFirstResponder];
}

@end
