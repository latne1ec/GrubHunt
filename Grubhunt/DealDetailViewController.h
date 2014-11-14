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
@property (weak, nonatomic) IBOutlet UITextView *specialTwoTextView;
@property (weak, nonatomic) IBOutlet UITextView *specialThreeTextView;
@property (weak, nonatomic) IBOutlet UITextView *termsOfUseTextView;
@property (weak, nonatomic) IBOutlet UITextView *couponCodeOneTextView;
@property (weak, nonatomic) IBOutlet UITextView *couponCodeTwoTextView;
@property (weak, nonatomic) IBOutlet UITextView *couponCodeThreeTextView;
@property (weak, nonatomic) NSString *dealChannel;
@property (nonatomic, strong) Deal *deal;
@property (nonatomic, strong) NSString *specialOneId;
@property (nonatomic, strong) NSString *specialTwoId;
@property (nonatomic, strong) NSString *specialThreeId;


@property (strong, nonatomic) IBOutlet UIButton *favButton;

@property (strong, nonatomic) IBOutlet UIButton *redeemButton;
@property (strong, nonatomic) IBOutlet UIButton *redeemButtonTwo;
@property (strong, nonatomic) IBOutlet UIButton *redeemButtonThree;

@property (strong, nonatomic) PFUser *user;




- (IBAction)redeemSpecialOne:(id)sender;
- (IBAction)redeemSpecialTwo:(id)sender;
- (IBAction)redeemSpecialThree:(id)sender;

- (IBAction)subscribeToChannel:(id)sender;



@end
