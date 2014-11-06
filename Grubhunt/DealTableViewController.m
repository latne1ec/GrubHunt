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

//***********************************
@interface DealTableViewController() <UISearchDisplayDelegate, UISearchBarDelegate> {
}
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchController;
@property (nonatomic, strong) NSMutableArray *searchResults;
@end
//***********************************


@interface DealTableViewController ()


@end

@implementation DealTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Reroute to initial view to create user
    PFUser *currentuser = [PFUser currentUser];
    if (currentuser) {
        [[PFUser currentUser] incrementKey:@"RunCount"];
    }
    
    else {
        [self performSegueWithIdentifier:@"showInitialView" sender:self];
    }
    
    //remove unused table cell lines
    self.tableView.tableFooterView = [UIView new];
    
    //No transparency on nav bar
    self.navigationController.navigationBar.translucent = NO;
    
    //Set up search bar
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    self.tableView.tableHeaderView = self.searchBar;
    self.searchController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    
    self.searchController.searchResultsDataSource = self;
    self.searchController.searchResultsDelegate = self;
    self.searchController.delegate = self;
    
    CGPoint offset = CGPointMake(0, self.searchBar.frame.size.height);
    self.tableView.contentOffset = offset;
    
    self.searchResults = [NSMutableArray array];
    
    
    [[UISearchBar appearance] setBackgroundImage:[UIImage imageNamed:@"searchBar.png"]];


}

- (void) viewWillAppear:(BOOL)animated {
    
    //Get users current location and save it to Parse
    if([PFUser currentUser]) {
        
        self.user = [PFUser currentUser];
        
        [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
            //NSLog(@"User is currently at %f, %f", geoPoint.latitude, geoPoint.longitude);
            
            [self.user setObject:geoPoint forKey:@"currentLocation"];
            [self.user saveInBackground];
            
            self.userLocation = geoPoint;
            [self loadObjects];
            
        }];
    }
}


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
        self.paginationEnabled = YES;
    }
    return self;
}


- (PFQuery *)queryForTable
{
    if (!self.userLocation) {
        return nil;
    }
    
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    [query orderByAscending:@"dealName"];
   // [query whereKey:@"dealLocation" nearGeoPoint:self.userLocation withinMiles:25];
    
    return query;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 232;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.tableView) {
        return self.objects.count;
        
        
        }
    
    else {
        return self.searchResults.count;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    static NSString *CellIdentifier = @"DealTableCell";
    DealTableCell *cell = (DealTableCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[DealTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        PFObject *searchedDeal = [self.searchResults objectAtIndex:indexPath.row];
        
        cell.nameLabel.text = [searchedDeal objectForKey:@"dealName"];
        cell.dealTeaser.text = [searchedDeal objectForKey:@"dealTeaser"];
        
        PFFile *thumbnail = [searchedDeal objectForKey:@"dealImage"];
        PFImageView *thumbnailImageView = (PFImageView*)cell.thumbnailImageView;
        thumbnailImageView.file = thumbnail;
        [thumbnailImageView loadInBackground];
    }
    
    else {
        
        //Configure the cell
        PFFile *thumbnail = [object objectForKey:@"dealImage"];
        PFImageView *thumbnailImageView = (PFImageView*)cell.thumbnailImageView;
        //thumbnailImageView.image = [UIImage imageNamed:@"TableCellFade.png"];
        thumbnailImageView.file = thumbnail;
        [thumbnailImageView loadInBackground];
    
        cell.nameLabel.text = [object objectForKey:@"dealName"];
        cell.dealTeaser.text = [object objectForKey:@"dealTeaser"];
       
        
        //cell.dealChannel = [object objectForKey:@"dealChannel"];

        }
    
    return cell;
    
}

//*****************************
//Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDealDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow]; DealDetailViewController *destViewController = segue.destinationViewController;
        
        if (self.searchDisplayController.active) {
            
        PFObject *searchResults = [self.searchResults objectAtIndex:indexPath.row];
        Deal *deal = [[Deal alloc] init];
        deal.name = [searchResults objectForKey:@"dealName"];
        deal.imageFile = [searchResults objectForKey:@"dealImage"];
        deal.description = [searchResults objectForKey:@"dealDescription"];
        deal.address = [searchResults objectForKey:@"dealAddress"];
        deal.contact = [searchResults objectForKey:@"dealContact"];
        deal.specialOne = [searchResults objectForKey:@"specialOne"];
        deal.termsOfUse = [searchResults objectForKey:@"termsOfUse"];
        deal.couponCode = [searchResults objectForKey:@"couponCode"];
        deal.channel = [searchResults objectForKey:@"dealChannel"];
        destViewController.deal= deal;
            
        } else {
        
        PFObject *object = [self.objects objectAtIndex:indexPath.row];
        Deal *deal = [[Deal alloc]init];
        deal.name = [object objectForKey:@"dealName"]; //changed to Directions
        deal.imageFile = [object objectForKey:@"dealImage"];
        deal.description = [object objectForKey:@"dealDescription"];
        deal.address = [object objectForKey:@"dealAddress"];
        deal.contact = [object objectForKey:@"dealContact"];
        deal.hours = [object objectForKey:@"dealHours"];
        deal.specialOne = [object objectForKey:@"specialOne"];
        deal.termsOfUse = [object objectForKey:@"termsOfUse"];
        deal.couponCode = [object objectForKey:@"couponCode"];
        deal.channel = [object objectForKey:@"dealChannel"];
        destViewController.deal= deal;
        
        destViewController.hidesBottomBarWhenPushed = YES;
            
        }
    }
}

//*******************************
//Search
- (void)filterResults:(NSString *)searchTerm {
    
    [self.searchResults removeAllObjects];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Deal"];
    [query whereKeyExists:@"dealName"];  //this is based on whatever query you are trying to accomplish
    [query whereKeyExists:@"dealTeaser"]; //this is based on whatever query you are trying to accomplish
    [query whereKey:@"dealName" containsString:searchTerm];
    
     NSArray *results = [query findObjects];
    
     [self.searchResults addObjectsFromArray:results];

}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterResults:searchString];
    
    return YES;
}

@end
