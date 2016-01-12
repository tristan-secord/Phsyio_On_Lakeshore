//
//  MakeAppt.h
//  Lakeshore Physiotherapy
//
//  Created by Tristan Secord on 2014-09-01.
//  Copyright (c) 2014 Tristan Secord. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>


@interface MakeAppt : UIViewController <MFMailComposeViewControllerDelegate> {
    IBOutlet UIScrollView *scroller;
}

@end
