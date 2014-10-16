//
//  WeekViewController.h
//  The Voice
//
//  Created by Lim Kuoy Suong on 8/9/14.
//  Copyright (c) 2014 LKS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "HeaderCollectionView.h"

@interface WeekViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *weekImageView;
@property (weak, nonatomic) IBOutlet UICollectionView *videosCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;


@property (strong,nonatomic) NSString *weekObjectId;
@property (strong,nonatomic) PFFile *weekImageFile;
@property (strong,nonatomic) NSString *weekTitle;
@property (strong,nonatomic) NSString *weekCategory;

@property (strong,nonatomic) NSString *userID;
@property (strong, nonatomic) NSMutableArray *objectIDs;
@property (strong, nonatomic) NSMutableArray *objectKeys;
@property (strong, nonatomic) NSMutableArray *objectCountKey;
@property (strong, nonatomic) NSMutableArray *objectTheSameKey;
//@property (strong, nonatomic) NSString *userID;

@end
