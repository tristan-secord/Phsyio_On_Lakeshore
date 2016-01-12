//
//  MoreViewController.m
//  Lakeshore Physiotherapy
//
//  Created by Tristan Secord on 2014-05-15.
//  Copyright (c) 2014 Tristan Secord. All rights reserved.
//

#import "MoreViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface MoreViewController ()

@end

@implementation MoreViewController

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

}
- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    self.scroller.scrollEnabled = YES;
    self.scroller.contentSize=CGSizeMake(320,2050);
    
    FBLikeControl *fbLikeControlView = [[FBLikeControl alloc] initWithFrame:CGRectMake(8, 2000, 200, 30)];
    fbLikeControlView.likeControlStyle = FBLikeControlStyleStandard;
    fbLikeControlView.objectID=@"https://www.facebook.com/pages/Physiotherapy-on-Lakeshore-Port-Credit-Mississauga/244788992245023";
    [self.scroller addSubview:fbLikeControlView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)callPhysio:(id)sender {
    NSString *phoneNumber = @"tel://9052782255";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}
@end
