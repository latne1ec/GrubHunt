//
//  DealDetailViewController.m
//  Grubhunt
//
//  Created by Evan Latner on 10/19/14.
//  Copyright (c) 2014 Level Labs. All rights reserved.
//

#import "DealDetailViewController.h"
#import "CNPPopupController.h"

@interface DealDetailViewController () <CNPPopupControllerDelegate>

@property (nonatomic, strong) CNPPopupController *popupController;


@end

@implementation DealDetailViewController

@synthesize dealImageView;
@synthesize dealLabel;
@synthesize descriptionTextView;
@synthesize deal;
@synthesize dealName;
@synthesize dealAddress;
@synthesize dealContact;
@synthesize dealHours;
@synthesize dealImageDvc;
@synthesize specialOneTextView;
@synthesize termsOfUseTextView;
@synthesize favButton;
@synthesize redeemButton;

@synthesize dealChannel;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //Button design
    CALayer *btnLayer = [redeemButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
    
    [redeemButton setTitleColor:[UIColor lightTextColor] forState:UIControlStateDisabled];

    
    self.title = deal.name;
    self.dealLabel.text = deal.name; //Changed to Directions
    self.dealContact.text = deal.contact;
    self.dealImageView.file = deal.imageFile;
    self.dealChannel = deal.channel;
    [dealImageView loadInBackground];

    
    NSMutableString *descriptionText = [NSMutableString string];
    for (NSString* description in deal.description) {
        [descriptionText appendFormat:@"%@\n", description];
    }
    self.descriptionTextView.text = descriptionText;
    
    NSMutableString *specialOneText = [NSMutableString string];
    for (NSString* specialOne in deal.specialOne) {
        [specialOneText appendFormat:@"%@\n", specialOne];
    }
    self.specialOneTextView.text = specialOneText;
    
    NSMutableString *termsOfUseText = [NSMutableString string];
    for (NSString* terms in deal.termsOfUse) {
        [termsOfUseText appendFormat:@"%@\n", terms];
    }
    self.termsOfUseTextView.text = termsOfUseText;

    
    NSMutableString *addressText = [NSMutableString string];
    for (NSString* address in deal.address) {
        [addressText appendFormat:@"%@\n", address];
    }
    self.dealAddress.text = addressText;
    
    NSMutableString *hoursText = [NSMutableString string];
    for (NSString* hour in deal.hours) {
        [hoursText appendFormat:@"%@\n", hour];
    }
    self.dealHours.text = hoursText;
    

}

- (void)redeemSpecialOne:(id)sender {
    
   // ((UIButton *)sender).enabled = NO;
    
    [self.redeemButton setEnabled:NO];

    [self showPopupWithStyle:CNPPopupStyleCentered];
    
    

}

- (void)showPopupWithStyle:(CNPPopupStyle)popupStyle {
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:(NSString*)deal.name attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:24], NSParagraphStyleAttributeName : paragraphStyle}];
    
    NSAttributedString *lineOne = [[NSAttributedString alloc] initWithString:(NSMutableString*)specialOneTextView.text attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20],  NSParagraphStyleAttributeName : paragraphStyle}];
    
    
    //self.dealImageView.file = deal.imageFile;
    
    UIImage *icon = [UIImage imageNamed:@"GrubHuntPlaceHolder.png"];
    
    
    NSAttributedString *lineTwo = [[NSAttributedString alloc] initWithString:@"Show this screen to your server to redeem offer" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18], NSForegroundColorAttributeName : [UIColor colorWithRed:173/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f], NSParagraphStyleAttributeName : paragraphStyle}];
    
    NSAttributedString *buttonTitle = [[NSAttributedString alloc] initWithString:@"Done" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName : [UIColor whiteColor], NSParagraphStyleAttributeName : paragraphStyle}];
    
    CNPPopupButtonItem *buttonItem = [CNPPopupButtonItem defaultButtonItemWithTitle:buttonTitle backgroundColor:[UIColor colorWithRed:173/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f]];
    buttonItem.selectionHandler = ^(CNPPopupButtonItem *item){
        //NSLog(@"Block for button: %@", item.buttonTitle.string);
    };
    
    self.popupController = [[CNPPopupController alloc] initWithTitle:title contents:@[lineOne, icon, lineTwo] buttonItems:@[buttonItem] destructiveButtonItem:nil];
    self.popupController.theme = [CNPPopupTheme defaultTheme];
    self.popupController.theme.popupStyle = popupStyle;
    self.popupController.delegate = self;
    self.popupController.theme.presentationStyle = CNPPopupPresentationStyleSlideInFromBottom;
    [self.popupController presentPopupControllerAnimated:YES];
}

#pragma mark - CNPPopupController Delegate

- (void)popupController:(CNPPopupController *)controller didDismissWithButtonTitle:(NSString *)title {
}

- (void)popupControllerDidPresent:(CNPPopupController *)controller {
}


- (void)subscribeToChannelInBackground {

    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    
    if (currentInstallation.channels == nil) {
        currentInstallation.channels = [[NSArray alloc] init];
    }
    
    [currentInstallation addUniqueObject:dealChannel forKey:@"channels"];
    [currentInstallation saveInBackground];

}

- (IBAction)subscribeToChannel:(id)sender {
    
    [self subscribeToChannelInBackground];
    
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Nice!!" message:@"This restaurant has been added to your favorites. You've got some great deals headed your way my friend." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alertview show];
    
}

//- (void)unsubscribeFromChannelInBackground {
//    
//    // When users indicate they are no longer Restaurant fans, we unsubscribe them.
//    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
//    [currentInstallation removeObject:dealChannel forKey:@"channels"];
//    [currentInstallation saveInBackground];
//}

@end
