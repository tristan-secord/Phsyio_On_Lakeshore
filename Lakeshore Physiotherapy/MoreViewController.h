//
//  MoreViewController.h
//  Lakeshore Physiotherapy
//
//  Created by Tristan Secord on 2014-05-15.
//  Copyright (c) 2014 Tristan Secord. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreViewController : UIViewController <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scroller;
- (IBAction)callPhysio:(id)sender;

@end
