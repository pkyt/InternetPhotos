//
//  Website.h
//  InternetPhotos
//
//  Created by Pavlo Kytsmey on 2/25/14.
//  Copyright (c) 2014 Pavlo Kytsmey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Website : NSManagedObject

@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSNumber * count;
@property (nonatomic, retain) NSSet *allPhotos;
@end

@interface Website (CoreDataGeneratedAccessors)

- (void)addAllPhotosObject:(NSManagedObject *)value;
- (void)removeAllPhotosObject:(NSManagedObject *)value;
- (void)addAllPhotos:(NSSet *)values;
- (void)removeAllPhotos:(NSSet *)values;

@end
