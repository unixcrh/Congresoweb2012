//
//  MasterViewController.m
//  Congresoweb
//
//  Created by Alberto Gimeno Brieba on 01/06/12.
//  Copyright (c) 2012 Level Apps S.L. All rights reserved.
//

#import "MasterViewController.h"

#import "AFJSONRequestOperation.h"
#import "SVPullToRefresh.h"
#import "DictionaryHelper.h"

#import "MapaViewController.h"

@interface MasterViewController () {

}

@property (nonatomic, retain) NSArray* records;

@end

@implementation MasterViewController

@synthesize table;
@synthesize records;
@synthesize detailViewController = _detailViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"", @"");
    }
    return self;
}
							
- (void)dealloc
{
    [table release];
    [records release];
    [super dealloc];
}

- (void)irAlMapa {
    MapaViewController* vc = [[MapaViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:@"ir al mapa" style:UIBarButtonItemStyleBordered target:self action:@selector(irAlMapa)];
    self.navigationItem.rightBarButtonItem = item;
    [item release];
    
    [table addPullToRefreshWithActionHandler:^ {
        NSString* url = @"http://www.dndzgz.com/fetch?service=bizi";
        NSURLRequest* req = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        AFJSONRequestOperation* operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:req success:^(NSURLRequest* req, NSHTTPURLResponse* resp, id JSON) {
            
            // [SVProgressHUD dismiss];
            
            NSLog(@"resultado = %@", JSON);
            
            self.records = JSON;
            [table.pullToRefreshView stopAnimating];
            [table reloadData];
            
        } failure:^(NSURLRequest* req, NSHTTPURLResponse* resp, NSError* err, id JSON) {
            NSLog(@"failure %@", [err localizedDescription]);
            
            // [SVProgressHUD showErrorWithStatus:[err localizedDescription] duration:4];
            [table.pullToRefreshView stopAnimating];
        }];
        [operation start];
    }];
    
}

- (void)viewDidUnload
{
    [self setTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return records.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    NSDictionary* object = [records objectAtIndex:indexPath.row];

    cell.textLabel.text = [object stringForKey:@"title"];
    cell.detailTextLabel.text = [object stringForKey:@"subtitle"];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
