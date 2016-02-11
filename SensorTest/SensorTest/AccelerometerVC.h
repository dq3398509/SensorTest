//
//  AccelerometerVC.h
//  SensorTest
//
//  Created by 董强 on 15/12/5.
//  Copyright © 2015年 董强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>


@interface AccelerometerVC : UIViewController


@property (nonatomic, strong) CMMotionManager *motionManager;

@end
