//
//  PhotosImageViewController.m
//  InternetPhotos2
//
//  Created by Pavlo Kytsmey on 3/3/14.
//  Copyright (c) 2014 Pavlo Kytsmey. All rights reserved.
//

#import "PhotosImageViewController.h"
#import "DownloadingPhoto.h"
#import "Photo.h"

@interface PhotosImageViewController ()

@end

@implementation PhotosImageViewController

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
	UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y + 20, self.view.bounds.size.width, self.view.bounds.size.height - 20)];
    Photo * p = [DownloadingPhoto getPhotoToShow];
    NSLog(@"%@", p.path);
    UIImage* img = [[UIImage alloc] initWithContentsOfFile:p.path];
    [imageView setImage:img];
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
