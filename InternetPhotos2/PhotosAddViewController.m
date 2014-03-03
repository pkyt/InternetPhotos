//
//  PhotosAddViewController.m
//  InternetPhotos2
//
//  Created by Pavlo Kytsmey on 3/3/14.
//  Copyright (c) 2014 Pavlo Kytsmey. All rights reserved.
//

#import "PhotosAddViewController.h"
#import "DownloadingPhoto.h"

@interface PhotosAddViewController ()

@property UITextField* text;
@property UIImageView* imageView;
- (IBAction)buttonPressed:(UIButton *)sender;
- (UIButton*)createButtonWithName:(NSString*)name withX:(float)x withY:(float)y withWidth:(float)width withHeight:(float)height withSelector:(SEL)selector;

@end

@implementation PhotosAddViewController

@synthesize text = _text;
@synthesize imageView = _imageView;

- (IBAction)buttonPressed:(UIButton *)sender{
    NSLog(@"got here");
    _text.text = [DownloadingPhoto downloadPhotoWithURL:_text.text withImagePlace:_imageView];
}

- (UIButton*)createButtonWithName:(NSString*)name withX:(float)x withY:(float)y withWidth:(float)width withHeight:(float)height withSelector:(SEL)selector{
#define delta 1
    CGRect buttonRect = CGRectMake(x + delta ,y + delta ,width - 2*delta, height-2*delta);
    UIButton* button = [[UIButton alloc] initWithFrame:buttonRect];
    button.layer.cornerRadius = 10;
    button.clipsToBounds = YES;
    [button setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:name forState:UIControlStateNormal];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor yellowColor]];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button.userInteractionEnabled = YES;
    return button;
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
    [self.view setBackgroundColor:[UIColor whiteColor]];
    NSInteger x = self.view.bounds.origin.x;
    NSInteger y = self.view.bounds.origin.y;
    NSInteger width = self.view.bounds.size.width;
    NSInteger height = self.view.bounds.size.height;
	_text = [[UITextField alloc] initWithFrame:CGRectMake(x + 1, y + 60, width - 2, height/10)];
    _text.text = @"paste a link";
    [self.view addSubview:_text];
    UIButton* button = [self createButtonWithName:@"Download" withX:x withY:y + 60 + height/10 withWidth:width withHeight:height/10 withSelector:@selector(buttonPressed:)];
    [self.view addSubview:button];
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x + 1, y + 60 + height/5, width - 2, 4*height/5 - 60)];
    [self.view addSubview:_imageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
