//
//  DealTableViewController.m
//  Grubhunt
//
//  Created by Evan Latner on 10/19/14.
//  Copyright (c) 2014 Level Labs. All rights reserved.
//

#import "DealTableViewController.h"
#import "Deal.h"
#import "DealTableCell.h"
#import "DealDetailViewController.h"

@interface DealTableViewController ()

@end

@implementation DealTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Reroute to an initial view to create a user
//    PFUser *currentuser = [PFUser currentUser];
//    if (currentuser) {
//        NSLog(@"Current user: %@", currentuser);
//        
//        [[PFInstallation currentInstallation] setObject:[PFUser currentUser] forKey:@"user"];
//        [[PFInstallation currentInstallation] saveEventually];
//        NSLog(@"Created user object on Installation Class");
//        
//    }
//    
//    else {
//        [self performSegueWithIdentifier:@"showInitialView" sender:self];
//    }
}

//- (void) viewWillAppear:(BOOL)animated {
//    
//    //Get users current location and save it to Parse
//    if([PFUser currentUser])
//    {
//        self.user = [PFUser currentUser];
//        
//        [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
//            NSLog(@"User is currently at %f, %f", geoPoint.latitude, geoPoint.longitude);
//            
//            [self.user setObject:geoPoint forKey:@"currentLocation"];
//            [self.user saveInBackground];
//            
//            self.userLocation = geoPoint;
//            [self loadObjects];
//            
//        }];
//    }
//}


- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        //The className to query on
        self.parseClassName = @"Deal";
        
        //The key of the PFObject to display in the label of the default cell style
        self.textKey = @"dealName";
        
        //Whether the built in pull to refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        //Whether the built in pagination is enabled
        self.paginationEnabled = NO;
    }
    return self;
}


- (PFQuery *)queryForTable
{
//    if (!self.userLocation) {
//        return nil;
//    }
    
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
//    [query whereKey:@"dealLocation" nearGeoPoint:self.userLocation withinMiles:50];
//    
//    if (query == nil) {
//        NSLog(@"No venues here");
//    }
    
    return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    static NSString *CellIdentifier = @"DealTableCell";
    
    DealTableCell *cell = (DealTableCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //Configure the cell
    PFFile *thumbnail = [object objectForKey:@"dealImage"];
    PFImageView *thumbnailImageView = (PFImageView*)cell.thumbnailImageView;
    thumbnailImageView.image = [UIImage imageNamed:@"GhPlaceholder.png"];
    thumbnailImageView.file = thumbnail;
    [thumbnailImageView loadInBackground];
    
    cell.nameLabel.text = [object objectForKey:@"dealName"];
    cell.dealTeaser.text = [object objectForKey:@"dealTeaser"];
    
    return cell;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDealDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow]; DealDetailViewController *destViewController = segue.destinationViewController;
        
        PFObject *object = [self.objects objectAtIndex:indexPath.row];
        Deal *deal = [[Deal alloc]init];
        deal.name = [object objectForKey:@"dealName"]; //changed to Directions
        deal.imageFile = [object objectForKey:@"dealImage"];
        deal.description = [object objectForKey:@"dealDescription"];
        deal.address = [object objectForKey:@"dealAddress"];
        deal.contact = [object objectForKey:@"dealContact"];
        deal.hours = [object objectForKey:@"dealHours"];
        deal.specialOne = [object objectForKey:@"specialOne"];
        deal.specialTwo = [object objectForKey:@"specialTwo"];
        deal.channel = [object objectForKey:@"dealChannel"];
        destViewController.deal= deal;
        
        destViewController.hidesBottomBarWhenPushed = YES;
    }
}

@end
