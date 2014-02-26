//
//  PhotosUploadViewController.h
//  InternetPhotos
//
//  Created by Pavlo Kytsmey on 2/25/14.
//  Copyright (c) 2014 Pavlo Kytsmey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotosUploadViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *userMessage;
@property (weak, nonatomic) IBOutlet UITextField *website;
@property (weak, nonatomic) IBOutlet UIImageView *imageTest;
- (IBAction)UplaodAction:(UIButton *)sender;

@end
