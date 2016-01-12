//
//  ExerciseViewController.m
//  Lakeshore Physiotherapy
//
//  Created by Tristan Secord on 2014-05-20.
//  Copyright (c) 2014 Tristan Secord. All rights reserved.
//

#import "ExerciseViewController.h"
#import "exerciseCollectionViewCell.h"
#import "ImageZoom.h"

@interface ExerciseViewController (){
    NSDictionary *exerciseDic;
    NSMutableArray *picNames;
    NSMutableArray *picString;
    exerciseCollectionViewCell *cell;
}

//@property (weak, nonatomic) IBOutlet UILabel *exerciseDescription;

@end
@implementation ExerciseViewController

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
    
    [[self exerciseCollectionView]setDataSource:self];
    [[self exerciseCollectionView]setDelegate:self];
    
    self.exerciseName.title = self.exDetail.name;
    self.exerciseDescription.text = self.exDetail.details;
        
    //Insantiation
    self.myScrollView.contentSize = CGSizeMake(320, _exerciseDescription.contentSize.height);
    
    
    //Getting file
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"numPics" withExtension:@"plist"];
    exerciseDic = [[NSDictionary alloc] initWithContentsOfURL:url];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    int numItems = [[exerciseDic objectForKey:self.exDetail.name] intValue];
    return numItems;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"Cell";
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    NSString *picNum = [NSString stringWithFormat:@"_%i.png", (int)(indexPath.item + 1)];
    NSString *temp = [self.exDetail.name stringByAppendingString:picNum];
    NSString *picName = [temp stringByReplacingOccurrencesOfString:@"/" withString:@" "];
    [cell.exerciseImage setImage: [UIImage imageNamed:picName]];
    
    picNames = [[NSMutableArray alloc]init];
    [picNames addObject:cell.exerciseImage];

    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
        NSString *picNum = [NSString stringWithFormat:@"_%i.png", (int)(selectedIndexPath.item + 1)];
        NSString *temp = [self.exDetail.name stringByAppendingString:picNum];
        NSString *picName = [temp stringByReplacingOccurrencesOfString:@"/" withString:@" "];
        ImageZoom *iz = [segue destinationViewController];
        iz.picName = [self.exDetail.name stringByReplacingOccurrencesOfString:@"/" withString:@" "];
        iz.imageName = picName;
    }
}

@end
