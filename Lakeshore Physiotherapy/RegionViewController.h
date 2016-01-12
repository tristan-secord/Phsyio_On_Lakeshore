//
//  RegionViewController.h
//  Lakeshore Physiotherapy
//
//  Created by Tristan Secord on 2014-05-17.
//  Copyright (c) 2014 Tristan Secord. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegionViewController : UICollectionViewController
<UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) NSArray *regionImages;
@property (strong, nonatomic) NSIndexPath *selectedCell;
@end
