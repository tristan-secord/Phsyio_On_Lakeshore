//
//  ExerciseTableViewController.m
//  Lakeshore Physiotherapy
//
//  Created by Tristan Secord on 2014-05-05.
//  Copyright (c) 2014 Tristan Secord. All rights reserved.
//

#import "ExerciseTableViewController.h"
#import "Exercise.h"
#import "ExerciseViewController.h"

@interface ExerciseTableViewController () {
    NSMutableDictionary *exerciseDic;
    NSMutableArray *sortedArray;
    NSMutableArray *keys;
    NSMutableDictionary *dic;
}
@property (strong, nonatomic) NSMutableArray *searchResults;
@property IBOutlet UISearchBar *searchBar;

@end



@implementation ExerciseTableViewController

@synthesize searchResults;
@synthesize searchBar;

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
    
    //Insantiation
    NSArray *exerciselist;
    exerciselist = [[NSArray alloc]init];
    exerciseDic = [[NSMutableDictionary alloc]init];
    
    //Getting file
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"ExerciseList" withExtension:@"plist"];
    exerciseDic = [NSMutableDictionary dictionaryWithContentsOfURL:url];
    exerciselist = exerciseDic.allKeys;
    dic = [[NSMutableDictionary alloc]init];
    
    
    //sort all exercises
    sortedArray = [[NSMutableArray alloc]initWithArray:[exerciselist sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]];
    self.searchResults = [NSMutableArray arrayWithCapacity:[sortedArray count]];
    
    //Create array of headers
    for (NSString *word in sortedArray) {
        NSString *firstLetter = [[word substringToIndex:1] uppercaseString];
        NSMutableArray *letterList = [dic objectForKey:firstLetter];
        if (!letterList) {
            letterList = [NSMutableArray array];
            [dic setObject:letterList forKey:firstLetter];
        }
        [letterList addObject:word];
    }
    
    //create sorted array of keys
    NSArray *temp = [dic allKeys];
    keys = [[NSMutableArray alloc]init];
    keys = [[NSMutableArray alloc]initWithArray:[temp sortedArrayUsingSelector:@selector(compare:)]];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.searchDisplayController.active) {
        return nil;
    } else {
        return keys[section];
    }
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray* index = [[NSMutableArray alloc]init];
    
    if (self.searchDisplayController.active){
        return nil;
    } else {
        [index addObject:UITableViewIndexSearch];
        for (NSString *letter in keys) {
            if (([letter intValue] != 0) && (![index containsObject:@"#"])){
                [index addObject:@"#"];
            }else if (([keys indexOfObject:letter] % 2) == 0) {
                [index addObject:@" ● "];
            } else {
                [index addObject:letter];
            }
        }
    }
    return index;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return 1;
    } else {
        return keys.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section
    NSArray *sectionArray = [[NSArray alloc]init];
    sectionArray = [dic valueForKey:[keys objectAtIndex:section]];
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchResults count];
    } else {
        return [sectionArray count];
    }
    
}

- (NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    
    if (index == 0){
        [tableView setContentOffset:CGPointMake(0.0, -tableView.contentInset.top) animated:NO];
        return NSNotFound;
    }
    
    return index - 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Exercise"];
    
    NSArray *exArray = [dic valueForKey:keys[indexPath.section]];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Exercise"];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
        
    } else {
        cell.textLabel.text = [exArray objectAtIndex:indexPath.row];
    }
    return cell;
}

#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [self.searchResults removeAllObjects];
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@",searchText];
    searchResults = [NSMutableArray arrayWithArray:[sortedArray filteredArrayUsingPredicate:predicate]];
}


#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    ExerciseViewController *pv = [segue destinationViewController];
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    Exercise *exe = [[Exercise alloc]init];
    NSArray *secArray;
    secArray = [dic valueForKey:[keys objectAtIndex:path.section]];
    exe.name = secArray[path.row];
    exe.details = [exerciseDic valueForKey:secArray[path.row]];
    pv.exDetail = exe;
}


@end