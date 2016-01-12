//
//  ExerciseViewController.h
//  Lakeshore Physiotherapy
//
//  Created by Tristan Secord on 2014-05-20.
//  Copyright (c) 2014 Tristan Secord. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Exercise.h"

@interface ExerciseViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UINavigationItem *exerciseName;
@property (weak, nonatomic) IBOutlet UICollectionView *exerciseCollectionView;
@property (weak, nonatomic) IBOutlet UITextView *exerciseDescription;
@property (unsafe_unretained, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (nonatomic) Exercise *exDetail;
@end
