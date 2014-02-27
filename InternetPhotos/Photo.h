//
//  Photo.h
//  InternetPhotos
//
//  Created by Pavlo Kytsmey on 2/26/14.
//  Copyright (c) 2014 Pavlo Kytsmey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Website;

@interface Photo : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * path;
@property (nonatomic, retain) NSDate * uploadDate;
@property (nonatomic, retain) Website *fromWhere;

@end
