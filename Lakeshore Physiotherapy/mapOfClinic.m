//
//  mapOfClinic.m
//  Lakeshore Physiotherapy
//
//  Created by Tristan Secord on 2014-12-24.
//  Copyright (c) 2014 Tristan Secord. All rights reserved.
//

#import "mapOfClinic.h"
#import <GoogleMaps/GoogleMaps.h>


@interface mapOfClinic ()

@end

@implementation mapOfClinic  {
    GMSMapView *mapView_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Controls whether the My Location dot and accuracy circle is enabled.
    self.mapView.myLocationEnabled = YES;
    //Controls the type of map tiles that should be displayed.
    self.mapView.mapType = kGMSTypeNormal;
    //Shows the compass button on the map
    self.mapView.settings.compassButton = YES;
    //Shows the my location button on the map
    self.mapView.settings.myLocationButton = YES;
    //Sets the view controller to be the GMSMapView delegate
    self.mapView.delegate = self;
    
    //43.543334, -79.594633
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:43.543334
                                                            longitude:-79.594633
                                                                 zoom:15];
    
    self.mapView.camera = camera;
    self.mapView.myLocationEnabled  = YES;
    
    // Creates a marker in the center of the map.
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(43.543334, -79.594633);
    marker.title = @"Physiotherapy on Lakeshore";
    marker.snippet = @"Mississauga";
    marker.map = self.mapView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)BackButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
