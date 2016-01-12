//
//  RegionTableView.m
//  Lakeshore Physiotherapy
//
//  Created by Tristan Secord on 2014-06-29.
//  Copyright (c) 2014 Tristan Secord. All rights reserved.
//

#import "RegionTableView.h"
#import "ExerciseViewController.h"
#import "Exercise.h"

@interface RegionTableView (){
    NSMutableDictionary *allRegionDic;
    NSMutableDictionary *tempDic;
    NSDictionary *exerciseDic;
    NSMutableArray *sortedArray;
    NSMutableArray *sortedArray2;
    NSMutableArray *sortedArray3;
    NSMutableArray *sortedArray4;
    NSMutableArray *sortedArray5;
    NSMutableArray *sortedArray6;
    NSMutableArray *workouts;
    NSMutableArray *regionArray;
    NSMutableArray *regionArray2;
    NSMutableArray *regionArray3;
    NSMutableArray *regionArray4;
    NSMutableArray *regionArray5;
    NSMutableArray *regionArray6;
}@end

@implementation RegionTableView

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"regionList" withExtension:@"plist"];
    allRegionDic = [NSMutableDictionary dictionaryWithContentsOfURL:url];
    url = [[NSBundle mainBundle]URLForResource:@"ExerciseList" withExtension:@"plist"];
    exerciseDic = [NSMutableDictionary dictionaryWithContentsOfURL:url];
    
   regionArray = [[NSMutableArray alloc]initWithArray:[allRegionDic allKeysForObject:self.regionName]];
    if ([self.regionName isEqualToString:@"Arms"]) {
        regionArray2 = [[NSMutableArray alloc]initWithArray:[allRegionDic allKeysForObject:@"Biceps"]];
        regionArray3 = [[NSMutableArray alloc]initWithArray:[allRegionDic allKeysForObject:@"Triceps"]];
    } else if ([self.regionName isEqualToString:@"Legs"]) {
        regionArray2 = [[NSMutableArray alloc]initWithArray:[allRegionDic allKeysForObject:@"Calves"]];
        regionArray3 = [[NSMutableArray alloc]initWithArray:[allRegionDic allKeysForObject:@"Glutues"]];
        regionArray4 = [[NSMutableArray alloc]initWithArray:[allRegionDic allKeysForObject:@"Hamstring"]];
        regionArray5 = [[NSMutableArray alloc]initWithArray:[allRegionDic allKeysForObject:@"Shin"]];
        regionArray6 = [[NSMutableArray alloc]initWithArray:[allRegionDic allKeysForObject:@"Quadriceps"]];
    } else if ([self.regionName isEqualToString:@"Back"]) {
        regionArray2 = [[NSMutableArray alloc]initWithArray:[allRegionDic allKeysForObject:@"Lower Back"]];
    }
    
    NSArray *keys = [allRegionDic allKeys];
    for (int i = 0; i < allRegionDic.count; i++) {
        NSString *keyName = [[NSString alloc] initWithString:[keys objectAtIndex:i]];

        if ([[allRegionDic objectForKey: keyName] isKindOfClass:[NSArray class]] == YES) {
            NSArray *regionArrayExercises = [[NSArray alloc] initWithArray:[allRegionDic objectForKey:keyName]];
            for (int j = 0; j < regionArrayExercises.count; j++) {
                if ([[regionArrayExercises objectAtIndex:j] isEqualToString:self.regionName]){
                    [regionArray addObject: keyName];
                }
                if ([self.regionName isEqualToString:@"Arms"]) {
                    if ([[regionArrayExercises objectAtIndex:j] isEqualToString:@"Biceps"]){
                        [regionArray2 addObject: keyName];
                    }
                    else if ([[regionArrayExercises objectAtIndex:j] isEqualToString:@"Triceps"]) {
                        [regionArray3 addObject: keyName];
                    }
                }
                else if ([self.regionName isEqualToString:@"Legs"]) {
                    if ([[regionArrayExercises objectAtIndex:j] isEqualToString:@"Calves"]){
                        [regionArray2 addObject: keyName];
                    }
                    else if ([[regionArrayExercises objectAtIndex:j] isEqualToString:@"Gluteus"]) {
                        [regionArray3 addObject: keyName];
                    }
                    else if ([[regionArrayExercises objectAtIndex:j] isEqualToString:@"Hamstring"]) {
                        [regionArray4 addObject: keyName];
                    }
                    else if ([[regionArrayExercises objectAtIndex:j] isEqualToString:@"Shin"]) {
                        [regionArray5 addObject: keyName];
                    }
                    else if ([[regionArrayExercises objectAtIndex:j] isEqualToString:@"Quadriceps"]) {
                        [regionArray6 addObject: keyName];
                    }
                }
                else if ([self.regionName isEqualToString:@"Back"]) {
                    if ([[regionArrayExercises objectAtIndex:j] isEqualToString:@"Lower Back"]){
                        [regionArray2 addObject: keyName];
                    }
                }
            }
        }
    }
    
    sortedArray = [[NSMutableArray alloc]initWithArray:[regionArray sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]];
    if ([self.regionName isEqualToString:@"Arms"]) {
        sortedArray2 = [[NSMutableArray alloc]initWithArray:[regionArray2 sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]];
        sortedArray3 = [[NSMutableArray alloc]initWithArray:[regionArray3 sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]];
    } else if ([self.regionName isEqualToString:@"Back"]) {
        sortedArray2 = [[NSMutableArray alloc]initWithArray:[regionArray2 sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]];
    } else if ([self.regionName isEqualToString:@"Legs"]) {
        sortedArray2 = [[NSMutableArray alloc]initWithArray:[regionArray2 sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]];
        sortedArray3 = [[NSMutableArray alloc]initWithArray:[regionArray3 sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]];
        sortedArray4 = [[NSMutableArray alloc]initWithArray:[regionArray4 sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]];
        sortedArray5 = [[NSMutableArray alloc]initWithArray:[regionArray5 sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]];
        sortedArray6 = [[NSMutableArray alloc]initWithArray:[regionArray6 sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]];
    }
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.regionName isEqualToString:@"Arms"])
        return 3;
    else if ([self.regionName isEqualToString:@"Back"])
        return 2;
    else if ([self.regionName isEqualToString:@"Legs"])
        return 6;
    else
        return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.regionName isEqualToString:@"Arms"]) {
        if (section == 0)
            return regionArray.count;
        else if (section == 1)
            return regionArray2.count;
        else
            return regionArray3.count;
    }
    else if ([self.regionName isEqualToString:@"Back"]) {
        if (section == 0)
            return regionArray.count;
        else
            return regionArray2.count;
    }
    else if ([self.regionName isEqualToString:@"Legs"]) {
        if (section == 0)
            return regionArray.count;
        else if (section == 1)
            return regionArray2.count;
        else if (section == 2)
            return regionArray3.count;
        else if (section == 3)
            return regionArray4.count;
        else if (section == 4)
            return regionArray5.count;
        else
            return regionArray6.count;
    }
    else
        return [regionArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"regionExercises" forIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"regionExercises"];
    }
    
    if ([self.regionName isEqualToString:@"Arms"]) {
        if (indexPath.section == 0)
            cell.textLabel.text = [sortedArray objectAtIndex:indexPath.row];
        else if (indexPath.section == 1)
            cell.textLabel.text = [sortedArray2 objectAtIndex:indexPath.row];
        else
            cell.textLabel.text = [sortedArray3 objectAtIndex:indexPath.row];
    }
    else if ([self.regionName isEqualToString:@"Back"]) {
        if (indexPath.section == 0)
            cell.textLabel.text = [sortedArray objectAtIndex:indexPath.row];
        else
            cell.textLabel.text = [sortedArray2 objectAtIndex:indexPath.row];
    }
    else if ([self.regionName isEqualToString:@"Legs"]) {
        if (indexPath.section == 0)
            cell.textLabel.text = [sortedArray objectAtIndex:indexPath.row];
        else if (indexPath.section == 1)
            cell.textLabel.text = [sortedArray2 objectAtIndex:indexPath.row];
        else if (indexPath.section == 2)
            cell.textLabel.text = [sortedArray3 objectAtIndex:indexPath.row];
        else if (indexPath.section == 3)
            cell.textLabel.text = [sortedArray4 objectAtIndex:indexPath.row];
        else if (indexPath.section == 4)
            cell.textLabel.text = [sortedArray5 objectAtIndex:indexPath.row];
        else
            cell.textLabel.text = [sortedArray6 objectAtIndex:indexPath.row];
    }
    else
        cell.textLabel.text = [sortedArray objectAtIndex:indexPath.row];
    
    // Configure the cell...
    
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([self.regionName isEqualToString:@"Arms"]) {
        if (section == 0)
            return (nil);
        else if (section == 1)
            return (@"Biceps");
        else
            return (@"Triceps");
    }
    else if ([self.regionName isEqualToString:@"Back"]) {
        if (section == 0)
            return (@"Back");
        else
            return (@"Lower Back");
    }
    else if ([self.regionName isEqualToString:@"Legs"]) {
        if (section == 0)
            return (@"Legs");
        else if (section == 1)
            return (@"Calves");
        else if (section == 2)
            return (@"Gluteus");
        else if (section == 3)
            return (@"Hamstrings");
        else if (section == 4)
            return (@"Shin");
        else
            return (@"Quadriceps");
    }
    else
        return nil;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    ExerciseViewController *pv = [segue destinationViewController];
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    Exercise *exe = [[Exercise alloc]init];
    exe.name = sortedArray[path.row];
    exe.details = [exerciseDic valueForKey:sortedArray[path.row]];
    pv.exDetail = exe;
}


@end
