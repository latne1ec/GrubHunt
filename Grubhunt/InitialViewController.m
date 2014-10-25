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

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
