//
//  WeekViewCell.h
//  The Voice
//
//  Created by Lim Kuoy Suong on 8/5/14.
//  Copyright (c) 2014 LKS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeekViewCell : UICollectionViewCell

// Property for each week data in View Controller
// Week view cell is in the Collection View

@property (weak, nonatomic) IBOutlet UIImageView *weekImageView;
@property (weak, nonatomic) IBOutlet UILabel *weekLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicatorView;
@property (weak, nonatomic) IBOutlet UILabel *weekDateLabel;
@end
