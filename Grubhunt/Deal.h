//
//  Deal.h
//  Grubhunt
//
//  Created by Evan Latner on 10/19/14.
//  Copyright (c) 2014 Level Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Deal : NSObject

@property (nonatomic, strong) NSString *name; //name of restuarant
@property (nonatomic, strong) NSString *teaser;
@property (nonatomic, strong) PFFile *imageFile;
@property (nonatomic, strong) NSString *image; //image filename of restuarant
@property (nonatomic, strong) NSArray *description;
@property (nonatomic, strong) NSArray *address;
@property (nonatomic, strong) NSString *contact;
@property (nonatomic, strong) NSArray *hours;
@property (nonatomic, strong) NSArray *specialOne;
@property (nonatomic, strong) NSArray *specialTwo;
@property (nonatomic, strong) NSArray *specialThree;
@property (nonatomic, strong) NSArray *termsOfUse;
@property (nonatomic, strong) NSArray *couponCodeOne;
@property (nonatomic, strong) NSArray *couponCodeTwo;
@property (nonatomic, strong) NSArray *couponCodeThree;
@property (nonatomic, strong) NSString *channel;
@property (nonatomic, strong) NSString *specialOneId;
@property (nonatomic, strong) NSString *specialTwoId;
@property (nonatomic, strong) NSString *specialThreeId;






@end
