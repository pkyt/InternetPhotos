//
//  DownloadingPhoto.m
//  InternetPhotos2
//
//  Created by Pavlo Kytsmey on 3/2/14.
//  Copyright (c) 2014 Pavlo Kytsmey. All rights reserved.
//

#import "DownloadingPhoto.h"
#import "Website.h"
#import "Photo.h"


@interface DownloadingPhoto ()

+ (NSString*)getNameFromURL:(NSString*)url;
+ (NSString*)getWebsiteNameFromURL:(NSString*)url;
+ (Website*)getWebisteFromDB:(NSString*)websiteName withDB:(id)delegate;

+ (Photo*)createPhotoWithWebsite:(Website*)web withName:(NSString*)name withPath:(NSString*)path withDB:(id)delegate;

@end

@implementation DownloadingPhoto

static Photo * photoToShow;

+ (void)setPhotoToShowWithWebsite:(Website*)web withIndex:(NSInteger)position withDB:(id)delegate{
    // NSManagedObjectContext *moc = [delegate managedObjectContext];
    NSArray* photos = [NSMutableArray arrayWithArray:[web.ownPhoto allObjects]];;
    if ([photos count] > position + 1) {
        NSLog(@"ERROR: number of elements is less than the position");
    }
    photoToShow = [photos objectAtIndex:position];
}

+ (Photo*)getPhotoToShow{
    if (!photoToShow) {
        return nil;
    }
    return photoToShow;
}

+ (NSString*)getNameFromURL:(NSString*)url{
    unsigned long pos = [url rangeOfString:@"/" options:NSBackwardsSearch].location;
    return [url substringFromIndex:pos+1];
}

+ (NSString*)getWebsiteNameFromURL:(NSString*)url{
    NSString* withOutHTTP = [url substringFromIndex:11];
    unsigned long pos = [withOutHTTP rangeOfString:@"/"].location;
    return [withOutHTTP substringToIndex:pos];
}

+ (Website*)getWebisteFromDB:(NSString *)websiteName withDB:(id)delegate{
    
    NSLog(@"webname: %@", websiteName);
    
    NSManagedObjectContext *moc = [delegate managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Website" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"name == %@", websiteName];
    [request setPredicate:predicate];
    NSError* error;
    NSArray* requestResult = [moc executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"ERROR: Wrong request to DB");
    }
    NSLog(@"%lu", [requestResult count]);

    if ([requestResult count] != 0) {
        if ([requestResult count] != 1) {
            NSLog(@"Warning: One Website appears twice");
        }
        return [requestResult objectAtIndex:0];
    }else{
        Website *WebsiteInfo = [NSEntityDescription
                                insertNewObjectForEntityForName:@"Website"
                                inManagedObjectContext:[delegate managedObjectContext]];
        [WebsiteInfo setCount:[NSNumber numberWithInt:0]];
        [WebsiteInfo setName:websiteName];
        NSEntityDescription *entityDescription1 = [NSEntityDescription
                                                  entityForName:@"Website" inManagedObjectContext:moc];
        NSFetchRequest *request1 = [[NSFetchRequest alloc] init];
        [request1 setEntity:entityDescription1];
        NSArray* websites = [moc executeFetchRequest:request1 error:&error];
        if (error) {
            NSLog(@"ERROR: Wrong request to DB");
        }
        [WebsiteInfo setWebID:[NSNumber numberWithInteger:[websites count]]];
        if (![[delegate managedObjectContext] save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        return WebsiteInfo;
    }
}

+ (Photo*)createPhotoWithWebsite:(Website *)web withName:(NSString *)name withPath:(NSString *)path withDB:(id)delegate{
    Photo *PhotoDetails = [NSEntityDescription
                           insertNewObjectForEntityForName:@"Photo"
                           inManagedObjectContext:[delegate managedObjectContext]];
    [PhotoDetails setName:name];
    [PhotoDetails setPath:path];
    [PhotoDetails setFromWhere:web];
    NSError *error;
    if (![[delegate managedObjectContext] save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    return PhotoDetails;
}


+ (NSString*)downloadPhotoWithURL:(NSString*)path withImagePlace:(UIImageView*)imageView{
    // NSString* stringURL = @"http://www.servethehome.com/wp-content/uploads/2013/01/STH-104-600.png";
    NSString* stringURL = path;
    NSLog(@"%@", [[NSBundle mainBundle] bundlePath]);
    
    
    NSURL* url = [NSURL URLWithString:stringURL];
    NSData* urlData = [NSData dataWithContentsOfURL:url];
    
    if (urlData) {
        NSFileManager* manager = [NSFileManager defaultManager];
        BOOL isDirectory;
        NSString *ourDir = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:[self getWebsiteNameFromURL:stringURL]];
        if (![manager fileExistsAtPath:ourDir isDirectory:&isDirectory] || !isDirectory) {
            NSError *error = nil;
            NSDictionary *attr = [NSDictionary dictionaryWithObject:NSFileProtectionComplete
                                                             forKey:NSFileProtectionKey];
            [manager createDirectoryAtPath:ourDir
               withIntermediateDirectories:YES
                                attributes:attr
                                     error:&error];
            if (error)
                NSLog(@"Error creating directory path: %@", [error localizedDescription]);
        }
        id delegate = [[UIApplication sharedApplication] delegate];
        Website* dir = [self getWebisteFromDB:[self getWebsiteNameFromURL:stringURL] withDB:delegate];
        NSString* filePath = [NSString stringWithFormat:@"%@/%@", ourDir, [self getNameFromURL:stringURL]];
        if (([manager fileExistsAtPath:filePath isDirectory:&isDirectory])&&(!isDirectory)) {
            UIImage* img = [[UIImage alloc] initWithContentsOfFile:filePath];
            imageView.image = img;
            return @"Image already exists";
        }
        NSError* error;
        [urlData writeToFile:filePath options:NSAtomicWrite error:&error];
        if (error) {
            return @"failed on loading";
        }
        [self createPhotoWithWebsite:dir
                            withName:[self getNameFromURL:stringURL]
                            withPath:filePath
                            withDB:delegate];
        
        UIImage* img = [[UIImage alloc] initWithContentsOfFile:filePath];
        imageView.image = img;
        return @"Image was succesfully added";
    }else{
        return @"not valid url of picture";
    }
}

@end
