//
//  FacebookViewController.h
//  The Voice
//
//  Created by Lim Kuoy Suong on 8/6/14.
//  Copyright (c) 2014 LKS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FacebookViewController : UIViewController <FBLoginViewDelegate>
@property (weak, nonatomic) IBOutlet FBLoginView *fbLoginView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *profileNameLabel;

@property (weak, nonatomic) IBOutlet FBProfilePictureView *profilePicture;

- (IBAction)doneButtonClicked:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UIButton *codyButton;


@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *closeImageView;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIButton *skipButton;

@end
