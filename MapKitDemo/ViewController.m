//
//  ViewController.m
//  MapKitDemo
//
//  Created by Yifan Zhu on 5/13/15.
//  Copyright (c) 2015 Yifan Zhu. All rights reserved.
//

#import "ViewController.h"
#import <Firebase/Firebase.h>
#define METERS_PER_MILE 1600

@import MapKit;
@import UIKit;

@interface ViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _mapView.delegate=self;
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude=39.281516;
    coordinate.longitude=-76.580806;
    
    MKPointAnnotation *annotation=[[MKPointAnnotation alloc] init];;
    [annotation setCoordinate:coordinate];
    [annotation setTitle:@"Test Pin"];
    [annotation setSubtitle:@"I am a subtitle"];
    [_mapView addAnnotation:annotation];
    
    MKPinAnnotationView *pin=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myPin"];

//    [pin setDraggable:YES];
    [pin setEnabled:YES];
    [pin setCanShowCallout:YES];
    
    NSLog(@"canSHowCallOUt now is %d", pin.canShowCallout);
//    [pin setSelected:YES animated:YES];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    // 1
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 39.281516;
    zoomLocation.longitude= -76.580806;
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    // 3
    [_mapView setRegion:viewRegion animated:YES];
}


//Delegate method to drag the pin
- (void)mapView:(MKMapView *)mapView
 annotationView:(MKAnnotationView *)annotationView
didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState
{
    if (newState == MKAnnotationViewDragStateEnding)
    {
        CLLocationCoordinate2D droppedAt = annotationView.annotation.coordinate;
        NSLog(@"Pin dropped at %f,%f", droppedAt.latitude, droppedAt.longitude);
        [annotationView.annotation setCoordinate:droppedAt];
    }
    
    switch (newState) {
        case MKAnnotationViewDragStateStarting:
            NSLog(@"Starting");
            break;
        case MKAnnotationViewDragStateDragging:
            NSLog(@"Dragging");
            break;
        case MKAnnotationViewDragStateCanceling:
            NSLog(@"Canceling");
            break;
            
        default:
            break;
    }
}

//Return the mapview of the annotation
- (MKAnnotationView *) mapView: (MKMapView *) mapView viewForAnnotation: (id<MKAnnotation>) annotation {
    MKPinAnnotationView *pin = (MKPinAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier: @"myPin"];
    if (pin == nil) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier: @"myPin"];
    } else {
        pin.annotation = annotation;
    }
    pin.animatesDrop = YES;
    pin.draggable = YES;
    pin.canShowCallout=YES;
    
    return pin;
}


@end
