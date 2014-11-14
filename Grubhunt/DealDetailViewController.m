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
@synthesize specialTwoTextView;
@synthesize specialThreeTextView;
@synthesize termsOfUseTextView;
@synthesize couponCodeOneTextView;
@synthesize couponCodeTwoTextView;
@synthesize couponCodeThreeTextView;
@synthesize favButton;
@synthesize redeemButton;
@synthesize redeemButtonTwo;
@synthesize redeemButtonThree;
@synthesize dealChannel;
@synthesize specialOneId;
@synthesize specialTwoId;
@synthesize specialThreeId;



- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.user = [PFUser currentUser];
//    [self.user addUniqueObject:@"locked" forKey:@"dealsRedeemed"];

    //Button design
    CALayer *btnLayer = [redeemButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:3.5f];
    
    CALayer *btnLayerTwo = [redeemButtonTwo layer];
    [btnLayerTwo setMasksToBounds:YES];
    [btnLayerTwo setCornerRadius:3.5f];
    
    CALayer *btnLayerThree = [redeemButtonThree layer];
    [btnLayerThree setMasksToBounds:YES];
    [btnLayerThree setCornerRadius:3.5f];
    
    
    [redeemButton setTitleColor:[UIColor lightTextColor] forState:UIControlStateDisabled];
    [redeemButton setTitle:@"Locked" forState:UIControlStateDisabled];
    
    [redeemButtonTwo setTitleColor:[UIColor lightTextColor] forState:UIControlStateDisabled];
    [redeemButtonTwo setTitle:@"Locked" forState:UIControlStateDisabled];

    [redeemButtonThree setTitleColor:[UIColor lightTextColor] forState:UIControlStateDisabled];
    [redeemButtonThree setTitle:@"Locked" forState:UIControlStateDisabled];

    
    self.title = deal.name;
    self.dealLabel.text = deal.name; //Changed to Directions
    self.dealContact.text = deal.contact;
    self.dealImageView.file = deal.imageFile;
    self.dealChannel = deal.channel;
    //self.specialOneId = deal.specialId;
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
    
    NSMutableString *specialTwoText = [NSMutableString string];
    for (NSString* specialTwo in deal.specialTwo) {
        [specialTwoText appendFormat:@"%@\n", specialTwo];
    }
    self.specialTwoTextView.text = specialTwoText;
    
    NSMutableString *specialThreeText = [NSMutableString string];
    for (NSString* specialThree in deal.specialThree) {
        [specialThreeText appendFormat:@"%@\n", specialThree];
    }
    self.specialThreeTextView.text = specialThreeText;
    
    NSMutableString *termsOfUseText = [NSMutableString string];
    for (NSString* terms in deal.termsOfUse) {
        [termsOfUseText appendFormat:@"%@\n", terms];
    }
    self.termsOfUseTextView.text = termsOfUseText;
    
    NSMutableString *couponCodeOneText = [NSMutableString string];
    for (NSString* couponCodeOne in deal.couponCodeOne) {
        [couponCodeOneText appendFormat:@"%@\n", couponCodeOne];
    }
    self.couponCodeOneTextView.text = couponCodeOneText;
    
    NSMutableString *couponCodeTwoText = [NSMutableString string];
    for (NSString* couponCodeTwo in deal.couponCodeTwo) {
        [couponCodeTwoText appendFormat:@"%@\n", couponCodeTwo];
    }
    self.couponCodeTwoTextView.text = couponCodeTwoText;
    
    NSMutableString *couponCodeThreeText = [NSMutableString string];
    for (NSString* couponCodeThree in deal.couponCodeThree) {
        [couponCodeThreeText appendFormat:@"%@\n", couponCodeThree];
    }
    self.couponCodeThreeTextView.text = couponCodeThreeText;

    
    NSMutableString *addressText = [NSMutableString string];
    for (NSString* address in deal.address) {
        [addressText appendFormat:@"%@\n", address];
    }
    self.dealAddress.text = addressText;
    

}

- (void) viewWillAppear:(BOOL)animated {
    
    PFUser *currentUser = [PFUser currentUser];
    NSArray *dealsRedeemed = [currentUser objectForKey:@"dealsRedeemed"];
    if ([dealsRedeemed containsObject:deal.specialOneId]) {

        //disable button
        redeemButton.enabled = NO;
    }
    
    else {
        //set button state to " enabled"
        redeemButton.enabled = YES;
    }
    
    if ([dealsRedeemed containsObject:deal.specialTwoId]) {
        
        //disable button
        redeemButtonTwo.enabled = NO;
       
    }
    
    else {
        //set button state to " enabled"
        redeemButtonTwo.enabled = YES;
    }
    
    if ([dealsRedeemed containsObject:deal.specialThreeId]) {
        
        //disable button
        redeemButtonThree.enabled = NO;
    }
    
    else {
        //set button state to " enabled"
        redeemButtonThree.enabled = YES;
    }
    
}

- (void)redeemSpecialOne: (id)sender {
    
    
    self.user = [PFUser currentUser];
    
    redeemButton.enabled = NO;
    
    [self.user addUniqueObject:deal.specialOneId forKey:@"dealsRedeemed"];
    [self.user saveInBackground];


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
    
    NSAttributedString *lineTwo = [[NSAttributedString alloc] initWithString:(NSMutableString*)couponCodeOneTextView.text attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18], NSForegroundColorAttributeName : [UIColor colorWithRed:173/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f], NSParagraphStyleAttributeName : paragraphStyle}];
    
    NSAttributedString *buttonTitle = [[NSAttributedString alloc] initWithString:@"Done" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName : [UIColor whiteColor], NSParagraphStyleAttributeName : paragraphStyle}];
    
    CNPPopupButtonItem *buttonItem = [CNPPopupButtonItem defaultButtonItemWithTitle:buttonTitle backgroundColor:[UIColor colorWithRed:197/255.0f green:1/255.0f blue:1/255.0f alpha:1.0f]];
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

- (void)redeemSpecialTwo: (id)sender {
    
    
        self.user = [PFUser currentUser];
    
        redeemButtonTwo.enabled = NO;
    
        [self.user addUniqueObject:deal.specialTwoId forKey:@"dealsRedeemed"];
        [self.user saveInBackground];
    
    
    [self showPopupWithStyleTwo:CNPPopupStyleCentered];
    
}

- (void)showPopupWithStyleTwo:(CNPPopupStyle)popupStyle {
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:(NSString*)deal.name attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:24], NSParagraphStyleAttributeName : paragraphStyle}];
    
    NSAttributedString *lineOne = [[NSAttributedString alloc] initWithString:(NSMutableString*)specialTwoTextView.text attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20],  NSParagraphStyleAttributeName : paragraphStyle}];
    
    //self.dealImageView.file = deal.imageFile;
    UIImage *icon = [UIImage imageNamed:@"GrubHuntPlaceHolder.png"];
    
    NSAttributedString *lineTwo = [[NSAttributedString alloc] initWithString:(NSMutableString*)couponCodeTwoTextView.text attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18], NSForegroundColorAttributeName : [UIColor colorWithRed:173/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f], NSParagraphStyleAttributeName : paragraphStyle}];
    
    NSAttributedString *buttonTitle = [[NSAttributedString alloc] initWithString:@"Done" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName : [UIColor whiteColor], NSParagraphStyleAttributeName : paragraphStyle}];
    
    CNPPopupButtonItem *buttonItem = [CNPPopupButtonItem defaultButtonItemWithTitle:buttonTitle backgroundColor:[UIColor colorWithRed:197/255.0f green:1/255.0f blue:1/255.0f alpha:1.0f]];
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

- (void)redeemSpecialThree: (id)sender {
    
    
        self.user = [PFUser currentUser];
    
        redeemButtonThree.enabled = NO;
    
        [self.user addUniqueObject:deal.specialThreeId forKey:@"dealsRedeemed"];
        [self.user saveInBackground];
    
    
    [self showPopupWithStyleThree:CNPPopupStyleCentered];
    
}

- (void)showPopupWithStyleThree:(CNPPopupStyle)popupStyle {
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:(NSString*)deal.name attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:24], NSParagraphStyleAttributeName : paragraphStyle}];
    
    NSAttributedString *lineOne = [[NSAttributedString alloc] initWithString:(NSMutableString*)specialThreeTextView.text attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20],  NSParagraphStyleAttributeName : paragraphStyle}];
    
    //self.dealImageView.file = deal.imageFile;
    UIImage *icon = [UIImage imageNamed:@"GrubHuntPlaceHolder.png"];
    
    NSAttributedString *lineTwo = [[NSAttributedString alloc] initWithString:(NSMutableString*)couponCodeThreeTextView.text attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18], NSForegroundColorAttributeName : [UIColor colorWithRed:173/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f], NSParagraphStyleAttributeName : paragraphStyle}];
    
    NSAttributedString *buttonTitle = [[NSAttributedString alloc] initWithString:@"Done" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName : [UIColor whiteColor], NSParagraphStyleAttributeName : paragraphStyle}];
    
    CNPPopupButtonItem *buttonItem = [CNPPopupButtonItem defaultButtonItemWithTitle:buttonTitle backgroundColor:[UIColor colorWithRed:197/255.0f green:1/255.0f blue:1/255.0f alpha:1.0f]];
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

    if (floor(NSFoundationVersionNumber) < NSFoundationVersionNumber_iOS_7_1) {
        // if running iOS 7
        
        if ([[UIApplication sharedApplication] enabledRemoteNotificationTypes]) {
            
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Nice!" message:@"This restaurant has been added to your favorites. You've got some great deals headed your way." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alertview show];
            
        }
        
        else {
            
            [self subscribeToChannelInBackground];
            
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Houston, we have a problem." message:@"This restaurant has been added to your favorites but it looks like you need to enable push notifications before they can send you any deals. Go to your Phone Settings > Notifications > GrubHunt > Allow Notifications" delegate:nil cancelButtonTitle:@"Got it" otherButtonTitles:nil];
            
            [alertview show];
            
        }
    }
    
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1) {

    //if running iOS 8
    if ([[UIApplication sharedApplication] isRegisteredForRemoteNotifications]) {
        
        [self subscribeToChannelInBackground];
        
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Nice!" message:@"This restaurant has been added to your favorites. You've got some great deals headed your way." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alertview show];
        
    }
    
    else {
        
        [self subscribeToChannelInBackground];
        
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Houston, we have a problem!" message:@"This restaurant has been added to your favorites but it looks like you need to enable push notifications before they can send you any deals. Go to your Phone Settings > Notifications > GrubHunt > Allow Notifications" delegate:nil cancelButtonTitle:@"Got it" otherButtonTitles:nil];
        
        [alertview show];
        
        }
    }
}

@end
