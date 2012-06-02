//
//  MasterViewController.h
//  Congresoweb
//
//  Created by Alberto Gimeno Brieba on 01/06/12.
//  Copyright (c) 2012 Level Apps S.L. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (retain, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) DetailViewController *detailViewController;

@end
