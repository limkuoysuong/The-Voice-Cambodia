//
//  aboutUsViewController.h
//  
//
//  Created by Lim Kuoy Suong on 8/6/14.
//  Copyright (c) 2014 LKS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface aboutUsViewController : UIViewController <UIWebViewDelegate,MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *appIconImg;
@property (strong, nonatomic) IBOutlet UITextView *detailLabel;
@property (strong, nonatomic) IBOutlet UILabel *versionLabel;
@property (strong, nonatomic) IBOutlet UILabel *motoLabel;

@property (strong, nonatomic) IBOutlet UIWebView *contactWebView;

- (IBAction)backHomeBtn:(UIButton *)sender;
@end
