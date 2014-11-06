//
//  InitialViewController.m
//  Grubhunt
//
//  Created by Evan Latner on 10/24/14.
//  Copyright (c) 2014 Level Labs. All rights reserved.
//

#import "InitialViewController.h"
#import <Parse/Parse.h>

@interface InitialViewController ()

@end

@implementation InitialViewController

@synthesize okButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CALayer *btnLayer = [okButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
    
    self.navigationItem.hidesBackButton = YES;

}

- (IBAction)createUser:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    [PFUser enableAutomaticUser];
    [[PFUser currentUser] incrementKey:@"RunCount"];
    [[PFUser currentUser] saveInBackground];
    NSLog(@"Created User");
    
}
@end
