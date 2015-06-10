//
//  MKPointAnnotation+setCoordinate.m
//  MapKitDemo
//
//  Created by Yifan Zhu on 5/13/15.
//  Copyright (c) 2015 Yifan Zhu. All rights reserved.
//

#import "MKPointAnnotation+setCoordinate.h"

@implementation MKPointAnnotation (setCoordinate)

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate{
    NSLog(@"%@",self);
    [self setCoordinate:newCoordinate];
}

@end
