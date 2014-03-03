//
//  PhotosSearchViewController.h
//  InternetPhotos2
//
//  Created by Pavlo Kytsmey on 3/2/14.
//  Copyright (c) 2014 Pavlo Kytsmey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotosSearchViewController : UITableViewController

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong) NSArray *websites;

@end
