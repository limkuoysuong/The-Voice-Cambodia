//
//  ViewController.m
//  The Voice
//
//  Created by Lim Kuoy Suong on 8/1/14.
//  Copyright (c) 2014 LKS. All rights reserved.
//

#import "ViewController.h"
#import "WeekViewController.h"
#import "WeekViewCell.h"
#import "FacebookViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
        NSMutableArray *arrayItem;
        NSArray *weekItems;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.profilePicture.profileID = self.userid;
    self.profilePicture.layer.borderWidth = 1.0f;
    self.profilePicture.layer.borderColor = [UIColor whiteColor].CGColor;
    self.profilePicture.clipsToBounds = YES;
    self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width/2;
    // Facebook Login
//    [self toggleHiddenState:YES];
//    [self fbLoginHiddenState:NO];
//       
//    self.LoginButton.delegate = self;
//    self.LoginButton.readPermissions = @[@"public_profile", @"email"];
    
//    self.profilePictures.layer.borderWidth = 2.0f;
//    self.profilePictures.layer.borderColor = [UIColor whiteColor].CGColor;
//    self.profilePictures.clipsToBounds = YES;
//    self.profilePictures.layer.cornerRadius = self.profilePictures.frame.size.width/2;
    
    
    
    self.navigationController.navigationBarHidden = YES;
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self.contentView setBackgroundColor:[UIColor clearColor]];
    [self.seasonTitle setFont:[UIFont fontWithName:@"HelveticaNeueLTStd-Th" size:18]];
    
    // Query item/photo of each week from parse to view controller
    
    PFQuery *query = [PFQuery queryWithClassName:@"WeekCollection"];
    [query orderByDescending:@"createdAt"];
    self.loadingWeek.hidden = NO;
    [self.loadingWeek startAnimating];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            weekItems = [[NSArray alloc]initWithArray:objects];
            [self.contentView reloadData];
            self.loadingWeek.hidden = YES;
            [self.loadingWeek stopAnimating];
        } else {
            NSLog(@"error");
        }
    }];
    
    //weekItems = [weekItems sortedArrayUsingSelector:@selector(com:)];
    
}

#pragma mark - Private method implementation

//- (void)fbLoginHiddenState: (BOOL)shouldHide{
//    //    UIImageView * backgroundImgView = [[UIImageView alloc]initWithFrame:self.view.frame];
//    //    backgroundImgView.image = [UIImage imageNamed:@"TheVoiceCambodia_FBSignIn_640.png"];
//    self.ImageViewOutlet.image = [UIImage imageNamed:@"TheVoiceCambodia_FBSignIn_640.png"];
//    self.ImageViewOutlet.hidden = shouldHide;
//    [self.view bringSubviewToFront:self.LoginButton];
//}
//
//-(void)toggleHiddenState:(BOOL)shouldHide{
//   // self.lblUsernames.hidden = shouldHide;
//   // self.profilePictures.hidden = shouldHide;
//    self.contentView.hidden = shouldHide;
//    self.seasonViewOutlet.hidden = shouldHide;
//}

#pragma mark - FBLoginView Delegate method implementation

//- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView{
//    NSLog(@"LoggedInUser");
//    [self toggleHiddenState:NO];
//    [self fbLoginHiddenState:YES];
//    self.LoginButton.hidden = YES;
//}
//
//- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView{
//    NSLog(@"LoggedOutUser");
//    [self toggleHiddenState:YES];
//   [self fbLoginHiddenState:NO];
//}
//
//- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user{
//    // self.profilePictures.profileID = user.id;
//     //self.lblUsernames.text = user.name;
//    
//    NSLog(@"Name = %@",user.name);
//}
//
//- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error{
//     NSLog(@"%@", [error localizedDescription]);
//}


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return weekItems.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    WeekViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    PFObject *weekObject = [weekItems objectAtIndex:indexPath.row];
    
    cell.weekDateLabel.text = [NSString stringWithFormat:@"%@ %@",[weekObject objectForKey:@"week"],[weekObject objectForKey:@"category"]];
    cell.weekDateLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:11];
    PFFile *file = [weekObject objectForKey:@"imageFile"];
    cell.loadingIndicatorView.hidden = NO;
    [cell.loadingIndicatorView startAnimating];
    [file getDataInBackgroundWithBlock:^(NSData *data,NSError *error){
        if (!error) {
            cell.weekImageView.image = [UIImage imageWithData:data];
            cell.loadingIndicatorView.hidden = YES;
            [cell.loadingIndicatorView stopAnimating];
        }
    }];
    
    NSDateFormatter *formatterDate = [[NSDateFormatter alloc]init];
    [formatterDate setDateFormat:@"dd/MM/yyyy"];
    NSString *stringWeekDate = [formatterDate stringFromDate:[weekObject objectForKey:@"weekDate"]];
    cell.weekLabel.text = stringWeekDate;
    
    return  cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PFObject *weekObject = [weekItems objectAtIndex:indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WeekViewController *weekVC = [storyboard instantiateViewControllerWithIdentifier:@"weekView"];
    weekVC.weekObjectId = weekObject.objectId;
    weekVC.weekImageFile = [weekObject objectForKey:@"imageFileBig"];
    weekVC.weekTitle = [weekObject objectForKey:@"week"];
    weekVC.weekCategory = [weekObject objectForKey:@"category"];
    weekVC.userID = self.userid;
    [self.navigationController pushViewController:weekVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)accountClicked:(UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
