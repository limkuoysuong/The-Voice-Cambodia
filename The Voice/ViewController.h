//
//  ViewController.h
//  The Voice
//
//  Created by Lim Kuoy Suong on 8/1/14.
//  Copyright (c) 2014 LKS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *contentView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingWeek;
@property (weak, nonatomic) IBOutlet UILabel *seasonTitle;
@property (strong,nonatomic) NSString *userid;

@property (strong, nonatomic) IBOutlet UIImageView *ImageViewOutlet;

//@property (weak, nonatomic) IBOutlet FBLoginView *LoginButton;

//@property (strong, nonatomic) IBOutlet UICollectionView *collectionViewOutlet;

// @property (weak, nonatomic) IBOutlet UILabel *lblUsernames;
@property (strong, nonatomic) IBOutlet UIView *seasonViewOutlet;

// for showing profile picture and clicking on it
-(IBAction)accountClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet FBProfilePictureView *profilePicture;


@end
