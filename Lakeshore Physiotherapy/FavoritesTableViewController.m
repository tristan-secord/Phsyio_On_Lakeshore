//
//  FavoritesTableViewController.m
//  Lakeshore Physiotherapy
//
//  Created by Tristan Secord on 2014-05-11.
//  Copyright (c) 2014 Tristan Secord. All rights reserved.
//

#import "FavoritesTableViewController.h"
#import "ExerciseViewController.h"
#import "AddFavoriteTableViewController.h"


@interface FavoritesTableViewController () {
    NSMutableArray *exerciselist;
    NSMutableDictionary *exerciseDic;
}
@property (strong, nonatomic) NSMutableArray *searchResults;
@property IBOutlet UISearchBar *searchBar;

@end



@implementation FavoritesTableViewController
@synthesize searchBar;
@synthesize searchResults;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    
    //Insantiation
    exerciseDic = [[NSMutableDictionary alloc]init];
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"ExerciseList" withExtension:@"plist"];
    exerciseDic = [NSMutableDictionary dictionaryWithContentsOfURL:url];
    
    //Getting file
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Favorites.dat"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:path])
        exerciselist = [[NSMutableArray alloc]initWithContentsOfFile:path];
    else
        exerciselist = [[NSMutableArray alloc]init];
    
    self.searchResults = [NSMutableArray arrayWithCapacity:[exerciselist count]];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchResults count];
    } else {
        return [exerciselist count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Exercise"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Exercise"];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = [exerciselist objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    
    if (index == 0) {
        [tableView setContentOffset:CGPointMake(0.0, -tableView.contentInset.top) animated:NO];
        return NSNotFound;
    }
    
    return index - 1;
}

#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [self.searchResults removeAllObjects];
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@",searchText];
    searchResults = [NSMutableArray arrayWithArray:[exerciselist filteredArrayUsingPredicate:predicate]];
}


#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Favorites.dat"];
        
        [self.tableView beginUpdates];
        [exerciselist removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [exerciselist writeToFile:path atomically:YES];
        [self.tableView endUpdates];
    }
}




// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Favorites.dat"];
    
    NSString *stringToMove = [exerciselist objectAtIndex:fromIndexPath.row];
    [exerciselist removeObjectAtIndex:fromIndexPath.row];
    [exerciselist insertObject:stringToMove atIndex:toIndexPath.row];

    [exerciselist writeToFile:path atomically:YES];
     
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier  isEqual: @"Add"]) {
    }
    else {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        ExerciseViewController *pv = [segue destinationViewController];
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        Exercise *exe = [[Exercise alloc]init];
        exe.name = exerciselist[path.row];
        exe.details = [exerciseDic valueForKey:exerciselist[path.row]];
        pv.exDetail = exe;
    }
}


@end
