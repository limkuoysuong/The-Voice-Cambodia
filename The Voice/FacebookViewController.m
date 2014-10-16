//
//  FacebookViewController.m
//  The Voice
//
//  Created by Lim Kuoy Suong on 8/6/14.
//  Copyright (c) 2014 LKS. All rights reserved.
//

#import "FacebookViewController.h"
#import "ViewController.h"

@interface FacebookViewController ()

@end

@implementation FacebookViewController{
    NSString *userId;
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
    self.fbLoginView.delegate = self;
    self.fbLoginView.readPermissions = @[@"public_profile", @"email"];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor blackColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView{
    //NSLog(@"LoggedInUser");
    self.backgroundImageView.hidden = YES;
    self.skipButton.hidden = YES;
    self.fbLoginView.hidden =NO;
    [self toggleHiddenState:NO];
 
//    PFObject *ParseUser = [PFObject objectWithClassName:@"FBUser"];
//    ParseUser[@"username"] = userId;
//    [ParseUser saveInBackground];
    
//    PFUser *user = [PFUser user];
//    user.username = userId;
//    user.password = @"my pass";
//    user.email = @"email@example.com";
//    
//    // other fields can be set just like with PFObject
//    user[@"phone"] = @"415-392-0202";
//    
//    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (!error) {
//            // Hooray! Let them use the app now.
//        } else {
//            NSString *errorString = [error userInfo][@"error"];
//            // Show the errorString somewhere and let the user try again.
//            NSLog(@"%@",errorString);
//        }
//    }];
    
    
}


- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView{
    //NSLog(@"LoggedOutUser");
    self.backgroundImageView.hidden = NO;
    self.skipButton.hidden = NO;
    self.fbLoginView.hidden = NO;
    [self toggleHiddenState:YES];
}

-(void)toggleHiddenState:(BOOL)shouldHide{
    self.profileNameLabel.hidden = shouldHide;
    self.profilePicture.hidden = shouldHide;
    
    self.codyButton.hidden = shouldHide;

    self.rateLabel.hidden = shouldHide;
    self.closeImageView.hidden =shouldHide;
    self.closeButton.hidden = shouldHide;
    
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user{
    
    userId = user.objectID;
    self.profilePicture.profileID = userId;
    self.profilePicture.layer.borderWidth = 2.0f;
    self.profilePicture.layer.borderColor = [UIColor whiteColor].CGColor;
    self.profilePicture.clipsToBounds = YES;
    self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width/2;
    self.profileNameLabel.text = user.name;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"weekController"];
    vc.userid = userId;
    [self.navigationController pushViewController:vc animated:NO];

}

- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error{
    //NSLog(@"%@", [error localizedDescription]);
}

- (IBAction)doneButtonClicked:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"weekController"];
    vc.userid = @"";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)closeButton:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"weekController"];
    vc.userid = userId;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
