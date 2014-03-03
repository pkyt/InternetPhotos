//
//  DownloadingPhoto.h
//  InternetPhotos2
//
//  Created by Pavlo Kytsmey on 3/2/14.
//  Copyright (c) 2014 Pavlo Kytsmey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Website.h"
#import "Photo.h"

@interface DownloadingPhoto : NSObject

+ (NSString*)downloadPhotoWithURL:(NSString*)path withImagePlace:(UIImageView*)imageView;
+ (void)setPhotoToShowWithWebsite:(Website*)web withIndex:(NSInteger)position withDB:(id)delegate;
+ (Photo*)getPhotoToShow;

@end
