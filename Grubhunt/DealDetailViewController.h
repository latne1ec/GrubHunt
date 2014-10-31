//
//  DealDetailViewController.h
//  Grubhunt
//
//  Created by Evan Latner on 10/19/14.
//  Copyright (c) 2014 Level Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Deal.h"

@interface DealDetailViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *dealLabel;
@property (nonatomic, strong) IBOutlet NSString *dealName;
@property (weak, nonatomic) IBOutlet PFImageView *dealImageView;
@property (weak, nonatomic) IBOutlet PFImageView *dealImageDvc;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (strong, nonatomic) IBOutlet UITextView *dealAddress;
@property (strong, nonatomic) IBOutlet UITextView *dealContact;
@property (weak, nonatomic) IBOutlet UITextView *dealHours;
@property (weak, nonatomic) IBOutlet UITextView *specialOneTextView;
@property (weak, nonatomic) IBOutlet UITextView *termsOfUseTextView;
@property (weak, nonatomic) NSString *dealChannel;
@property (nonatomic, strong) Deal *deal;

@property (strong, nonatomic) IBOutlet UIButton *favButton;

@property (strong, nonatomic) IBOutlet UIButton *redeemButton;

@property (strong, nonatomic) PFUser *user;


- (IBAction)redeemSpecialOne:(id)sender;

- (IBAction)subscribeToChannel:(id)sender;



@end
