//
//  ImageZoom.h
//  Lakeshore Physiotherapy
//
//  Created by Tristan Secord on 2014-12-27.
//  Copyright (c) 2014 Tristan Secord. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageZoom : UIViewController <UIScrollViewDelegate>

@property (nonatomic) NSString *imageName;
@property (nonatomic) NSString *picName;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UINavigationItem *imageTitle;

@end
