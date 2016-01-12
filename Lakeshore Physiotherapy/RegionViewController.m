//
//  RegionViewController.m
//  Lakeshore Physiotherapy
//
//  Created by Tristan Secord on 2014-05-17.
//  Copyright (c) 2014 Tristan Secord. All rights reserved.
//

#import "RegionViewController.h"
#import <UIKit/UIKit.h>
#import "CollectionViewCell.h"
#import "RegionTableView.h"

@interface RegionViewController ()
 {
     NSArray *regionNames;
     NSMutableDictionary *imageDictionary;
     CollectionViewCell *cell;
     UIImage *image;
}
@end

@implementation RegionViewController

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
    // Do any additional setup after loading the view.
    self.regionImages = @[@"elbow.png", @"hip.png", @"knee.png", @"shoulder.png", @"spine.png", @"wrist.png", @"ankle.png", @"abdominals.png", @"neck.png", @"legs.png", @"Arms.png", @"Back.png", @"chest.png", @"Forearms.png", @"Foot.png"];
    regionNames = [[NSArray alloc]initWithObjects:@"Elbow", @"Hips", @"Knee", @"Shoulder", @"Spine", @"Wrist", @"Ankle", @"Core", @"Neck", @"Legs", @"Arms", @"Back", @"Chest", @"Forearms", @"Feet", nil];
    
    self.title = @"Regions";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_regionImages count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Region" forIndexPath:indexPath];
    long row = [indexPath row];
    image = [UIImage imageNamed:_regionImages[row]];
    cell.imageView.image = image;
    cell.regionName.text = regionNames[row];
    return cell;
}

//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    
//}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *selectedRegion = [[NSString alloc]init];
    RegionTableView *rv = [segue destinationViewController];
    NSArray *temp = [self.collectionView indexPathsForSelectedItems];
    NSIndexPath *path = temp[0];
    selectedRegion = regionNames[path.row];
    rv.regionName = selectedRegion;
}


@end
