//
//  Website.h
//  InternetPhotos
//
//  Created by Pavlo Kytsmey on 2/26/14.
//  Copyright (c) 2014 Pavlo Kytsmey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photo;

@interface Website : NSManagedObject

@property (nonatomic, retain) NSNumber * count;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSNumber * websiteID;
@property (nonatomic, retain) NSSet *allPhotos;
@end

@interface Website (CoreDataGeneratedAccessors)

- (void)addAllPhotosObject:(Photo *)value;
- (void)removeAllPhotosObject:(Photo *)value;
- (void)addAllPhotos:(NSSet *)values;
- (void)removeAllPhotos:(NSSet *)values;

@end
