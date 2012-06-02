//
//  MapaViewController.m
//  Congresoweb
//
//  Created by Alberto Gimeno Brieba on 01/06/12.
//  Copyright (c) 2012 Level Apps S.L. All rights reserved.
//

#import "MapaViewController.h"
#import "AFJSONRequestOperation.h"
#import "DictionaryHelper.h"
#import "SVProgressHUD.h"

@interface MapaViewController ()

@end

@implementation MapaViewController
@synthesize imageView;
@synthesize map;

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
    // Do any additional setup after loading the view from its nib.
    
    imageView.image = [UIImage imageNamed:@"imagen"];
}

- (void)loadMap {
    [SVProgressHUD show];
    NSString* url = @"http://www.dndzgz.com/fetch?service=bizi";
    NSURLRequest* req = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFJSONRequestOperation* operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:req success:^(NSURLRequest* req, NSHTTPURLResponse* resp, id JSON) {
        
        NSArray* records = JSON;
        
        CLLocationDegrees maxLat = -90.0f;
        CLLocationDegrees maxLon = -180.0f;
        CLLocationDegrees minLat = 90.0f;
        CLLocationDegrees minLon = 180.0f;
        
        for (NSDictionary* dict in records) {
            
            MKPointAnnotation* ann = [[MKPointAnnotation alloc] init];
            ann.title = [dict stringForKey:@"title"];
            
            if ([ann.title isEqualToString:@"Parada 78"]) {
                continue;
            }
            
            CGFloat lat = [dict numberForKey:@"lat"].floatValue;
            CGFloat lon = [dict numberForKey:@"lon"].floatValue;
            
            ann.coordinate = CLLocationCoordinate2DMake(lat, lon);
            
            [map addAnnotation:ann];
            
            [ann release];
            
            maxLat = MAX(maxLat, lat);
            maxLon = MAX(maxLon, lon);
            minLat = MIN(minLat, lat);
            minLon = MIN(minLon, lon);
            
            NSLog(@"dict %@", dict);
            
        }
        
        MKCoordinateRegion region;
        region.center.latitude     = (maxLat + minLat) / 2;
        region.center.longitude    = (maxLon + minLon) / 2;
        region.span.latitudeDelta  = maxLat - minLat + 0.05;
        region.span.longitudeDelta = maxLon - minLon + 0.05;
        
        @try {
            [map setRegion:region animated:NO];
        }
        @catch (NSException *exception) {
            NSLog(@"exception %@", [exception description]);
        }
        
        [SVProgressHUD dismissWithSuccess:@"Yeah!"];
        
        
    } failure:^(NSURLRequest* req, NSHTTPURLResponse* resp, NSError* err, id JSON) {
        NSLog(@"failure %@", [err localizedDescription]);
        
        [SVProgressHUD dismissWithError:[err localizedDescription]];
        
    }];
    [operation start];

}

- (void)viewDidUnload
{
    [self setMap:nil];
    [self setImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [map release];
    [imageView release];
    [super dealloc];
}
@end
