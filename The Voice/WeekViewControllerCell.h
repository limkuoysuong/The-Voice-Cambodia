//
//  WeekViewControllerCell.h
//  The Voice
//
//  Created by Lim Kuoy Suong on 8/9/14.
//  Copyright (c) 2014 LKS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface WeekViewControllerCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *videoTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *videoImage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingVideo;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;



@end
