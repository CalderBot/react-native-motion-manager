#import <React/RCTBridge.h>
#import <React/RCTEventDispatcher.h>
#import "DeviceMotion.h"

@implementation DeviceMotion

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

- (id) init {
    self = [super init];
    NSLog(@"DeviceMotion");
    
    if (self) {
        self->_motionManager = [[CMMotionManager alloc] init];
        // DeviceMotion
        if([self->_motionManager isDeviceMotionAvailable])
        {
            NSLog(@"DeviceMotion available");
            /* Start the DeviceMotion if it is not active already */
            if([self->_motionManager isDeviceMotionActive] == NO)
            {
                NSLog(@"DeviceMotion active");
            } else {
                NSLog(@"DeviceMotion not active");
            }
        }
        else
        {
            NSLog(@"DeviceMotion not Available!");
        }
    }
    return self;
}

RCT_EXPORT_METHOD(setDeviceMotionUpdateInterval:(double) interval) {
    NSLog(@"setDeviceMotionUpdateInterval: %f", interval);
    [self->_motionManager setDeviceMotionUpdateInterval:interval];
}

RCT_EXPORT_METHOD(getDeviceMotionUpdateInterval:(RCTResponseSenderBlock) cb) {
    double interval = self->_motionManager.deviceMotionUpdateInterval;
    NSLog(@"getDeviceMotionUpdateInterval: %f", interval);
    cb(@[[NSNull null], [NSNumber numberWithDouble:interval]]);
}

RCT_EXPORT_METHOD(getDeviceMotionData:(RCTResponseSenderBlock) cb) {
    double gravity_x = self->_motionManager.deviceMotion.gravity.x;
    double gravity_y = self->_motionManager.deviceMotion.gravity.y;
    double gravity_z = self->_motionManager.deviceMotion.gravity.z;
    double magneticField_x = self->_motionManager.deviceMotion.magneticField.field.x;
    double magneticField_y = self->_motionManager.deviceMotion.magneticField.field.y;
    double magneticField_z = self->_motionManager.deviceMotion.magneticField.field.z;
    double rotationRate_x = self->_motionManager.deviceMotion.rotationRate.x;
    double rotationRate_y = self->_motionManager.deviceMotion.rotationRate.y;
    double rotationRate_z = self->_motionManager.deviceMotion.rotationRate.z;
    double roll = self->_motionManager.deviceMotion.attitude.roll;
    double pitch = self->_motionManager.deviceMotion.attitude.pitch;
    double yaw = self->_motionManager.deviceMotion.attitude.yaw;
    double userAcceleration_x = self->_motionManager.deviceMotion.userAcceleration.x;
    double userAcceleration_y = self->_motionManager.deviceMotion.userAcceleration.y;
    double userAcceleration_z = self->_motionManager.deviceMotion.userAcceleration.z;
    
    NSLog(@"getDeviceMotionData (gravity): %f, %f, %f", gravity_x, gravity_y, gravity_z);
    NSLog(@"getDeviceMotionData (rotationRate): %f, %f, %f", rotationRate_x, rotationRate_y, rotationRate_z);
    NSLog(@"getDeviceMotionData (magneticField): %f, %f, %f", magneticField_x, magneticField_y, magneticField_z);
    NSLog(@"getDeviceMotionData (attitude): %f, %f, %f", roll, pitch, yaw);
    NSLog(@"getDeviceMotionData (userAcceleration): %f, %f, %f", userAcceleration_x, userAcceleration_y, userAcceleration_z);
    
    cb(@[[NSNull null], @{
             @"gravity": @{
                     @"x" : [NSNumber numberWithDouble:gravity_x],
                     @"y" : [NSNumber numberWithDouble:gravity_y],
                     @"z" : [NSNumber numberWithDouble:gravity_z]
                     },
             @"magneticField": @{
                     @"x" : [NSNumber numberWithDouble:magneticField_x],
                     @"y" : [NSNumber numberWithDouble:magneticField_y],
                     @"z" : [NSNumber numberWithDouble:magneticField_z]
                     },
             @"rotationRate": @{
                     @"x" : [NSNumber numberWithDouble:rotationRate_x],
                     @"y" : [NSNumber numberWithDouble:rotationRate_y],
                     @"z" : [NSNumber numberWithDouble:rotationRate_z]
                     },
             @"attitude": @{
                     @"roll" : [NSNumber numberWithDouble:roll],
                     @"pitch" : [NSNumber numberWithDouble:pitch],
                     @"yaw" : [NSNumber numberWithDouble:yaw]
                     },
             @"userAcceleration": @{
                     @"x" : [NSNumber numberWithDouble:userAcceleration_x],
                     @"y" : [NSNumber numberWithDouble:userAcceleration_y],
                     @"z" : [NSNumber numberWithDouble:userAcceleration_z]
                     }
             }]
       );
}


RCT_EXPORT_METHOD(startDeviceMotionUpdates) {
    NSLog(@"startMagnetometerUpdatesUsingReferenceFrame");
    [self->_motionManager startDeviceMotionUpdates];
    
    /* Receive the DeviceMotion data on this block */
    /* It seems that for magneticField to work you need to use startDeviceMotionUpdatesUsingReferenceFrame:toQueue:withHandler.
     CMAttitudeReferenceFrameXArbitraryCorrectedZVertical may be another reasonable choice. */
    [self->_motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXTrueNorthZVertical
                                                              toQueue:[NSOperationQueue mainQueue]
                                                          withHandler:^(CMDeviceMotion *motionData, NSError *error)
     {
         double gravity_x = motionData.gravity.x;
         double gravity_y = motionData.gravity.y;
         double gravity_z = motionData.gravity.z;
         double magneticField_x = motionData.magneticField.field.x;
         double magneticField_y = motionData.magneticField.field.y;
         double magneticField_z = motionData.magneticField.field.z;
         double rotationRate_x = motionData.rotationRate.x;
         double rotationRate_y = motionData.rotationRate.y;
         double rotationRate_z = motionData.rotationRate.z;
         double roll = motionData.attitude.roll;
         double pitch = motionData.attitude.pitch;
         double yaw = motionData.attitude.yaw;
         double userAcceleration_x = motionData.userAcceleration.x;
         double userAcceleration_y = motionData.userAcceleration.y;
         double userAcceleration_z = motionData.userAcceleration.z;
         NSLog(@"startDeviceMotionUpdates (gravity): %f, %f, %f", gravity_x, gravity_y, gravity_z);
         NSLog(@"startDeviceMotionUpdates (rotationRate): %f, %f, %f", rotationRate_x, rotationRate_y, rotationRate_z);
         NSLog(@"startDeviceMotionUpdates (magneticField): %f, %f, %f", magneticField_x, magneticField_y, magneticField_z);
         NSLog(@"startDeviceMotionUpdates (attitude): %f, %f, %f", roll, pitch, yaw);
         NSLog(@"startDeviceMotionUpdates (userAcceleration): %f, %f, %f", userAcceleration_x, userAcceleration_y, userAcceleration_z);
         
         [self.bridge.eventDispatcher sendDeviceEventWithName:@"MotionData" body:@{
                                                                                   @"gravity": @{
                                                                                           @"x" : [NSNumber numberWithDouble:gravity_x],
                                                                                           @"y" : [NSNumber numberWithDouble:gravity_y],
                                                                                           @"z" : [NSNumber numberWithDouble:gravity_z]
                                                                                           },
                                                                                   @"magneticField": @{
                                                                                           @"x" : [NSNumber numberWithDouble:magneticField_x],
                                                                                           @"y" : [NSNumber numberWithDouble:magneticField_y],
                                                                                           @"z" : [NSNumber numberWithDouble:magneticField_z]
                                                                                           },
                                                                                   @"rotationRate": @{
                                                                                           @"x" : [NSNumber numberWithDouble:rotationRate_x],
                                                                                           @"y" : [NSNumber numberWithDouble:rotationRate_y],
                                                                                           @"z" : [NSNumber numberWithDouble:rotationRate_z]
                                                                                           },
                                                                                   @"attitude": @{
                                                                                           @"roll"  : [NSNumber numberWithDouble:roll],
                                                                                           @"pitch" : [NSNumber numberWithDouble:pitch],
                                                                                           @"yaw"   : [NSNumber numberWithDouble:yaw]
                                                                                           },
                                                                                   @"userAcceleration": @{
                                                                                           @"x" : [NSNumber numberWithDouble:userAcceleration_x],
                                                                                           @"y" : [NSNumber numberWithDouble:userAcceleration_y],
                                                                                           @"z" : [NSNumber numberWithDouble:userAcceleration_z]
                                                                                           },
                                                                                   }];
     }];
}

RCT_EXPORT_METHOD(stopDeviceMotionUpdates) {
    NSLog(@"stopDeviceMotionUpdates");
    [self->_motionManager stopDeviceMotionUpdates];
}

+ (BOOL)requiresMainQueueSetup {
    return NO;
}

@end
