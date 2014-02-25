//
//  PhotoSearchViewController.h
//  InternetPhotos
//
//  Created by Pavlo Kytsmey on 2/25/14.
//  Copyright (c) 2014 Pavlo Kytsmey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoSearchViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *searchFor;
- (IBAction)find:(UIButton*)sender;

@end
