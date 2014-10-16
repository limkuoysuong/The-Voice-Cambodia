//
//  aboutUsViewController.m
//  
//
//  Created by Lim Kuoy Suong on 8/6/14.
//  Copyright (c) 2014 LKS. All rights reserved.
//

#import "aboutUsViewController.h"

@interface aboutUsViewController ()

@end

@implementation aboutUsViewController

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
    
    self.contactWebView.delegate = self;
    self.versionLabel.text = @"Version 1.0.0";
    [self.versionLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTStd-Th" size:13]];;
    [self.versionLabel setTextColor:[UIColor colorWithRed:98/255.0f green:125/255.0f blue:142/255.0f alpha:1.0f]];
    
    self.detailLabel.text= @"With The Voice Cambodia App, you can watch all your favorite episodes of the show in just one place.";
    [self.detailLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTStd-Th" size:18.0]];
    
    [self.detailLabel setTextColor:[UIColor colorWithRed:98/255.0f green:125/255.0f blue:142/255.0f alpha:1.0f]];
    
    [self.motoLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTStd-Th" size:25]];
    [self.motoLabel setTextColor:[UIColor colorWithRed:98/255.0f green:125/255.0f blue:142/255.0f alpha:1.0f]];
    
    
    UIImage *AppIcon = [UIImage imageNamed:@"AppIcon_512.png"];
    [self.appIconImg setImage:AppIcon];

    
    NSMutableString *html = [NSMutableString stringWithString: @"<html><head><title></title></head><body>"];
    
    NSString *email = @"limkuoysuong@gmail.com";
    
    
    [html appendString:[NSString stringWithFormat:@"<p style='margin:7px 0 7px 0;float:left;font-family:HelveticaNeueLTStd-Th; font-size:14px; color:#4f6674;'>Feedback :</p><a href=\'custom://THIS_IS_CUSTOM_LINK\'><p style='margin:7px 0 7px 0;float:right;color:#076cd4;font-family:HelveticaNeueLTStd-Th;  font-size:14px;'>%@</p></a>",email]];
    
    [html appendString:@"<div style='clear:both;'></div>"];
    
    
    [html appendString:@"<div style='clear:both;'></div>"];
    
    [html appendString:[NSString stringWithFormat:@"<div style='border-top:solid #90aaba;border-top-width:1px;'></div>"]];
    
    [html appendString:@"</body></html>"];
    [self.contactWebView loadHTMLString:[html description] baseURL:nil];
    
    UIView* row = nil;
    for(row in self.contactWebView.subviews){
        if([row isKindOfClass:[UIScrollView class] ]){
            UIScrollView* scrollRow = (UIScrollView*) row;
            scrollRow.scrollEnabled = NO;
            scrollRow.bounces = NO;
            scrollRow.backgroundColor=[UIColor clearColor];
        }
    }
    
    UILabel *lbl1 = [[UILabel alloc] init];
    [lbl1 setFrame:CGRectMake((self.view.frame.size.width - 220)/2, self.view.frame.size.height - 20, 220, 20)];
    lbl1.backgroundColor=[UIColor clearColor];
    lbl1.textColor=[UIColor blackColor];
    lbl1.userInteractionEnabled=NO;
    lbl1.textAlignment = NSTextAlignmentCenter;
    [lbl1 setFont:[UIFont fontWithName: @"HelveticaNeueLTStd-Th" size: 11.0f]];
    [self.view addSubview:lbl1];
    lbl1.text= @"Copyright © 2014 LKS. All rights reserved.";
    
    // UIImageView *comLogoView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 40)/2, self.view.frame.size.height - 60, 40, 40)];
    // comLogoView.image = [UIImage imageNamed:@"shape_transparent.png"];
    // [self.view addSubview:comLogoView];
    

}

-(BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        
        if ([[[request URL] absoluteString] rangeOfString:@"custom://"].location != NSNotFound) {
            [self showEmail];
        }else{
            [[UIApplication sharedApplication] openURL:request.URL];
        }
    
        return NO;
    }
    return YES;
}

- (void)showEmail{
    
    NSArray *toRecipents = [NSArray arrayWithObject:@"cody.appinfo@gmail.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setToRecipients:toRecipents];
    [self presentViewController:mc animated:YES completion:NULL];
    
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            
            break;
        case MFMailComposeResultSaved:
            
            break;
        case MFMailComposeResultSent:
            
            break;
        case MFMailComposeResultFailed:{
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                   message:@"Failed to send Mail!"
                                                                  delegate:nil cancelButtonTitle:@"OK"
                                                         otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)backHomeBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:NO];
}
@end
