//
//  ImageZoom.m
//  Lakeshore Physiotherapy
//
//  Created by Tristan Secord on 2014-12-27.
//  Copyright (c) 2014 Tristan Secord. All rights reserved.
//

#import "ImageZoom.h"

@interface ImageZoom ()

@end

@implementation ImageZoom

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.scrollView.minimumZoomScale=1;
    self.scrollView.maximumZoomScale=6.0;
    self.scrollView.delegate=self;
    [self.image setImage:[UIImage imageNamed:self.imageName]];
    self.image.center = CGPointMake(144, 150);
    self.imageTitle.title = self.picName;
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
