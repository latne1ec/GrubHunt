//
//  DealTableViewController.h
//  Grubhunt
//
//  Created by Evan Latner on 10/19/14.
//  Copyright (c) 2014 Level Labs. All rights reserved.
//

#import <Parse/Parse.h>

@interface DealTableViewController : PFQueryTableViewController <UITableViewDelegate>

@property (nonatomic, strong) PFGeoPoint *userLocation;
@property (strong, nonatomic) PFUser *user;

@end
