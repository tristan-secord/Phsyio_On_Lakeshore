//
//  mapOfClinic.h
//  Lakeshore Physiotherapy
//
//  Created by Tristan Secord on 2014-12-24.
//  Copyright (c) 2014 Tristan Secord. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface mapOfClinic : UIViewController <GMSMapViewDelegate>

- (IBAction)BackButton:(id)sender;
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;

@end
