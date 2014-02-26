//
//  PhotosUploadViewController.m
//  InternetPhotos
//
//  Created by Pavlo Kytsmey on 2/25/14.
//  Copyright (c) 2014 Pavlo Kytsmey. All rights reserved.
//

#import "PhotosUploadViewController.h"
#import "Website.h"
#import "Photo.h"

@interface PhotosUploadViewController ()

- (NSString*)downloadPhotoWithURL:(NSString*)path;
- (NSString*)getNameFromURL:(NSString*)url;
- (NSString*)getWebsiteNameFromURL:(NSString*)url;

@end

@implementation PhotosUploadViewController


- (NSString*)getNameFromURL:(NSString*)url{
    unsigned long pos = [url rangeOfString:@"/" options:NSBackwardsSearch].location;
    return [url substringFromIndex:pos+1];
}
- (NSString*)getWebsiteNameFromURL:(NSString*)url{
    NSString* withOutHTTP = [url substringFromIndex:11];
    unsigned long pos = [withOutHTTP rangeOfString:@"/"].location;
    return [withOutHTTP substringToIndex:pos];
}

- (NSString*)downloadPhotoWithURL:(NSString*)path{
    NSString* stringURL = @"http://www.servethehome.com/wp-content/uploads/2013/01/STH-104-600.png";
    NSLog(@"%@", [[NSBundle mainBundle] bundlePath]);

    
    NSURL* url = [NSURL URLWithString:stringURL];
    NSData* urlData = [NSData dataWithContentsOfURL:url];
    
    if (urlData) {
        NSFileManager* manager = [NSFileManager defaultManager];
        BOOL isDirectory;
        Website* dir;
        Photo* pht;
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
            // dir = [NSEntityDescription insertNewObjectForEntityForName:@"Website"
             //                                   inManagedObjectContext:<#(NSManagedObjectContext *)#>];
        }
        
        NSString* filePath = [NSString stringWithFormat:@"%@/%@", ourDir, [self getNameFromURL:stringURL]];
        if (([manager fileExistsAtPath:filePath isDirectory:&isDirectory])&&(!isDirectory)) {
            UIImage* img = [[UIImage alloc] initWithContentsOfFile:filePath];
            self.imageTest.image = img;
            return @"Image already exists";
        }
        NSError* error = nil;
        [urlData writeToFile:filePath options:NSAtomicWrite error:&error];
        if (error) {
            return @"failed on loading";
        }
        
        UIImage* img = [[UIImage alloc] initWithContentsOfFile:filePath];
        self.imageTest.image = img;
        return @"Image was succesfully added";
    }else{
        return @"not valid url of picture";
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)UplaodAction:(UIButton *)sender {
    self.userMessage.text = [self downloadPhotoWithURL:@""];
}
@end
