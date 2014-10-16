//
//  WeekViewController.m
//  The Voice
//
//  Created by Lim Kuoy Suong on 8/9/14.
//  Copyright (c) 2014 LKS. All rights reserved.
//

#import "WeekViewController.h"
#import "WeekViewControllerCell.h"
#import "VideoViewController.h"

@interface WeekViewController ()

@end

@implementation WeekViewController{
    HeaderCollectionView *headerView;
    NSArray *videoItems;
    NSDictionary *monday;
    NSInteger countLose;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    PFQuery *query = [PFQuery queryWithClassName:@"VideoTables"];
    [query whereKey:@"weekId" equalTo:self.weekObjectId];
    [query orderByAscending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            videoItems = [[NSArray alloc]initWithArray:objects];
            [self.videosCollectionView reloadData];
            
        } else {
            
        }
        
    }];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //NSLog(@"view did load back");
    [self.videosCollectionView setBackgroundColor:[UIColor clearColor]];
    [self.view setBackgroundColor:[UIColor clearColor]];
    PFFile *file = self.weekImageFile;
    self.loadingIndicator.hidden = NO;
    [self.loadingIndicator startAnimating];
    [file getDataInBackgroundWithBlock:^(NSData *data,NSError *error){
        if (!error) {
            self.weekImageView.image = [UIImage imageWithData:data];
            self.loadingIndicator.hidden = YES;
            [self.loadingIndicator stopAnimating];
        }
    }];
    
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissButton:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return videoItems.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    WeekViewControllerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"videoCell" forIndexPath:indexPath];
    PFObject *videoObject = [videoItems objectAtIndex:indexPath.row];
    cell.videoTitleLabel.text = [videoObject objectForKey:@"videoTitle"];
    cell.videoTitleLabel.font = [UIFont fontWithName:@"KhmerOSKangrey" size:14];
    
    cell.likeLabel.text = [NSString stringWithFormat:@"LOVED : %@",[videoObject objectForKey:@"countLike"]];
    cell.likeLabel.font = [UIFont fontWithName:@"HelveticaNeueLTStd-BlkCn" size:13];

    PFFile *file = [videoObject objectForKey:@"videoImage"];
    cell.loadingVideo.hidden = NO;
    [cell.loadingVideo startAnimating];
    cell.videoImage.image = [UIImage imageNamed:@"theVoice_placeholder.png"];
    [file getDataInBackgroundWithBlock:^(NSData *data,NSError *error){
        if (!error) {
            cell.videoImage.image = [UIImage imageWithData:data];
            cell.loadingVideo.hidden = YES;
            [cell.loadingVideo stopAnimating];
        }
    }];
    
    [cell setBackgroundColor:[UIColor blackColor]];
    
    return  cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        headerView.weekTitle.text = self.weekTitle;
        headerView.weekTitle.font = [UIFont fontWithName:@"HelveticaNeueLTStd-BlkCnO" size:40];
        headerView.weekCategory.text = self.weekCategory;
        headerView.weekCategory.font = [UIFont fontWithName:@"HelveticaNeueLTStd-BlkCn" size:20];
        reusableview = headerView;
    }
    return reusableview;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PFObject *videoObject = [videoItems objectAtIndex:indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    VideoViewController *videoVC = [storyboard instantiateViewControllerWithIdentifier:@"videoview"];
    videoVC.videoKey = [videoObject objectForKey:@"videoKey"];
    videoVC.userID = self.userID;
    videoVC.countLike = [videoObject objectForKey:@"countLike"];
    [self.navigationController pushViewController:videoVC animated:YES];
    countLose = [[NSUserDefaults standardUserDefaults]integerForKey:@"loseHard"];
    countLose++;
    [[NSUserDefaults standardUserDefaults]setInteger:countLose forKey:@"loseHard"];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentSize.height - scrollView.contentOffset.y > (self.view.bounds.size.height)) {
        
        if (scrollView.contentOffset.y > 0) {
            headerView.alpha = 1 - (scrollView.contentOffset.y) / 80;
            self.backButton.alpha = 1- (scrollView.contentOffset.y) / 80;
            self.backImageView.alpha = 1- (scrollView.contentOffset.y) / 80;
        }else{
            headerView.alpha = 1.0f;
            self.backButton.alpha = 1.0f;
            self.backImageView.alpha = 1.0f;
        }
        
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
