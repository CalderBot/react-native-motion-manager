//
//  Altimeter.m
//  RNMotionManager
//
//  Created by Calder Daenzer on 8/14/17.


#import <React/RCTBridge.h>
#import <React/RCTEventDispatcher.h>
#import "Altimeter.h"

@implementation Altimeter

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

- (id) init {
    self = [super init];
    NSLog(@"Altimeter");
    
    if (self) {
        self->_altimeter = [[CMAltimeter alloc] init];
    }
    return self;
}


RCT_EXPORT_METHOD(startRelativeAltitudeUpdates) {
    NSLog(@"startRelativeAltitudeUpdates");
    
    /* Receive the relative altitude data on this block */
    [self->_altimeter startRelativeAltitudeUpdatesToQueue:[NSOperationQueue mainQueue]
                                              withHandler:^(CMAltitudeData *altitudeData, NSError *error)
     {
         NSLog(@"startRelativeAltitudeUpdates");
         [self.bridge.eventDispatcher sendDeviceEventWithName:@"AltimeterData"
                                                         body:@{@"altimeter": @{@"pressure" : altitudeData.pressure,
                                                                                @"relativeAltitude" : altitudeData.relativeAltitude}}];
     }];
    
}


RCT_EXPORT_METHOD(stopRelativeAltitudeUpdates) {
    NSLog(@"stopRelativeAltitudeUpdates");
    [self->_altimeter stopRelativeAltitudeUpdates];
}

+ (BOOL)requiresMainQueueSetup {
    return NO;
}

@end

