//
//  FavoritesTableViewController.h
//  Lakeshore Physiotherapy
//
//  Created by Tristan Secord on 2014-05-11.
//  Copyright (c) 2014 Tristan Secord. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "AddFavoriteTableViewController.h"
#include "Exercise.h"

@interface FavoritesTableViewController : UITableViewController <UISearchDisplayDelegate, UISearchBarDelegate>

@property (nonatomic) Exercise *exercise;

@end
