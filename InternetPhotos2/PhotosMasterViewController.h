//
//  PhotosMasterViewController.h
//  InternetPhotos2
//
//  Created by Pavlo Kytsmey on 2/27/14.
//  Copyright (c) 2014 Pavlo Kytsmey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotosMasterViewController : UITableViewController

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong) NSArray *websites;

@end
