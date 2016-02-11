//
//  MagnetometerVC.m
//  SensorTest
//
//  Created by 董强 on 15/12/5.
//  Copyright © 2015年 董强. All rights reserved.
//

#import "MagnetometerVC.h"
#import <CoreLocation/CoreLocation.h>

@interface MagnetometerVC ()<CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *magneticHeadingLabel;

@property (weak, nonatomic) IBOutlet UILabel *trueHeadingLabel;

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation MagnetometerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.imgView.image = [UIImage imageNamed:@"plate"];
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    
    if ([CLLocationManager headingAvailable]) {

        [self.locationManager startUpdatingHeading];
    } else {
        
        NSLog(@"无法获得数据");
    }
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [self.locationManager stopUpdatingHeading];
    self.locationManager.delegate = nil;
    
}


- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    
    UIDevice *device = [UIDevice currentDevice];
    

    if (newHeading.headingAccuracy > 0) {
        
        float magneticHeading = [self heading:newHeading.magneticHeading fromOrientation:device.orientation];
        
        float trueHeading = [self heading:newHeading.trueHeading fromOrientation:device.orientation];
        
        
        self.magneticHeadingLabel.text = [NSString stringWithFormat:@"%.2f", magneticHeading];
        self.trueHeadingLabel.text = [NSString stringWithFormat:@"%.2f", trueHeading];
        
        self.imgView.transform = CGAffineTransformMakeRotation( -M_PI * newHeading.magneticHeading / 180.0);
    }
    
    
}


-(float)heading:(float)heading fromOrientation:(UIDeviceOrientation) orientation {
    
    float realHeading = heading;
    switch (orientation) {
        case UIDeviceOrientationPortrait:
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            realHeading = realHeading - 180.0f;
            break;
        case UIDeviceOrientationLandscapeLeft:
            realHeading = realHeading + 90.0f;
            break;
        case UIDeviceOrientationLandscapeRight:
            realHeading = realHeading - 90.0f;
            break;
        default:
            break;
    }
    if (realHeading > 360.0f) {
        realHeading -= 360;
    } else if (realHeading < 0.0f) {
        realHeading += 360;
    }
    return realHeading;
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

@end
