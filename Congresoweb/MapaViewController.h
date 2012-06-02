//
//  MapaViewController.h
//  Congresoweb
//
//  Created by Alberto Gimeno Brieba on 01/06/12.
//  Copyright (c) 2012 Level Apps S.L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapaViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIImageView *imageView;

@property (retain, nonatomic) IBOutlet MKMapView *map;


@end
