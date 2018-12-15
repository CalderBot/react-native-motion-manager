//
//  Altimeter.h
//  RNMotionManager
//
//  Created by Calder Daenzer on 8/14/17.
#import <React/RCTBridgeModule.h>
#import <CoreMotion/CoreMotion.h>

@interface Altimeter : NSObject <RCTBridgeModule> {
    CMAltimeter *_altimeter;
}
- (void) startRelativeAltitudeUpdates;
- (void) stopRelativeAltitudeUpdates;
+ (BOOL) requiresMainQueueSetup;

@end
