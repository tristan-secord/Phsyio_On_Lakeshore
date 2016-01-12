//
//  AddFavoriteTableViewController.h
//  Lakeshore Physiotherapy
//
//  Created by Tristan Secord on 2014-05-11.
//  Copyright (c) 2014 Tristan Secord. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddFavoriteTableViewController;

@protocol FavoritesDelegate;

@interface AddFavoriteTableViewController : UITableViewController <UISearchDisplayDelegate, UISearchBarDelegate, UITableViewDelegate>

@property NSString *selectedEx;
@property (nonatomic, weak) id<FavoritesDelegate> delegate;

@end

@protocol FavoritesDelegate <NSObject>

-(void) updateFavoritesTV:(AddFavoriteTableViewController *)tvc;

@end
