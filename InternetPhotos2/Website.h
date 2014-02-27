//
//  Website.h
//  InternetPhotos2
//
//  Created by Pavlo Kytsmey on 2/27/14.
//  Copyright (c) 2014 Pavlo Kytsmey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photo;

@interface Website : NSManagedObject

@property (nonatomic, retain) NSNumber * webID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * count;
@property (nonatomic, retain) NSSet *ownPhoto;
@end

@interface Website (CoreDataGeneratedAccessors)

- (void)addOwnPhotoObject:(Photo *)value;
- (void)removeOwnPhotoObject:(Photo *)value;
- (void)addOwnPhoto:(NSSet *)values;
- (void)removeOwnPhoto:(NSSet *)values;

@end
