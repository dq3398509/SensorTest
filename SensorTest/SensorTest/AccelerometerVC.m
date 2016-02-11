//
//  AccelerometerVC.m
//  SensorTest
//
//  Created by 董强 on 15/12/5.
//  Copyright © 2015年 董强. All rights reserved.
//

#import "AccelerometerVC.h"

@interface AccelerometerVC ()<UIAccelerometerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *xLabel;
@property (weak, nonatomic) IBOutlet UILabel *yLabel;
@property (weak, nonatomic) IBOutlet UILabel *zLabel;

@property (weak, nonatomic) IBOutlet UIProgressView *xBar;
@property (weak, nonatomic) IBOutlet UIProgressView *yBar;
@property (weak, nonatomic) IBOutlet UIProgressView *zBar;

@property (weak, nonatomic) IBOutlet UILabel *directionLabel;
@property (weak, nonatomic) IBOutlet UILabel *shakeLabel;

@end

@implementation AccelerometerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

    self.shakeLabel.font = [UIFont boldSystemFontOfSize:28];
    self.shakeLabel.textAlignment = NSTextAlignmentCenter;
    
    // 设置更新频率
//    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:0.5];
    
    // 签代理
//    [[UIAccelerometer sharedAccelerometer] setDelegate:self];
    
    [self UsemotionManager];
    
    NSLog(@"123123123");
    
    
}


- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{


    self.xLabel.text = [NSString stringWithFormat:@"%f", acceleration.x];
    self.xBar.progress = ABS(acceleration.x) / 1;

    self.yLabel.text = [NSString stringWithFormat:@"%f", acceleration.y];
    self.yBar.progress = ABS(acceleration.y) / 1;  // ABS取绝对值
    
    self.zLabel.text = [NSString stringWithFormat:@"%f", acceleration.z];
    self.zBar.progress = ABS(acceleration.z) / 1;
    
}




- (void)UsemotionManager
{
    
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = 0.5;
    
    if ([self.motionManager isAccelerometerAvailable]) {
        
        [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            
            if (error) {
             
                [self.motionManager stopAccelerometerUpdates];
            } else {
            
                self.xLabel.text = [NSString stringWithFormat:@"%f", accelerometerData.acceleration.x];
                self.xBar.progress = ABS(accelerometerData.acceleration.x);
                
                
                self.yLabel.text = [NSString stringWithFormat:@"%f", accelerometerData.acceleration.y];
                self.yBar.progress = ABS(accelerometerData.acceleration.y);

                
                self.zLabel.text = [NSString stringWithFormat:@"%f", accelerometerData.acceleration.z];
                self.zBar.progress = ABS(accelerometerData.acceleration.z);
            }
            
        }];
    }
    
}




/**
 *  方向
 */

- (void)viewWillAppear:(BOOL)animated
{
    // 可以获取设备信息和操作系统信息
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    // 通知中心
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(directionChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    
}

- (void)directionChange:(NSNotification *)noti
{

    UIDevice *device = [UIDevice currentDevice];
    
    switch (device.orientation) {
        case UIDeviceOrientationPortrait:
            self.directionLabel.text = @"竖直向上";
            break;
            
        case UIDeviceOrientationPortraitUpsideDown:
            self.directionLabel.text = @"竖直向下";
            break;
            
        case UIDeviceOrientationLandscapeLeft:
            self.directionLabel.text = @"水平向左";
            break;
            
        case UIDeviceOrientationLandscapeRight:
            self.directionLabel.text = @"水平向右";
            break;
            
        case UIDeviceOrientationFaceUp:
            self.directionLabel.text = @"正面向上";
            break;
            
        case UIDeviceOrientationFaceDown:
            self.directionLabel.text = @"正面向下";
            break;
            
        default:
            self.directionLabel.text = @"未知";
            break;
    }
    
    self.directionLabel.font = [UIFont boldSystemFontOfSize:28];
    self.directionLabel.textAlignment = NSTextAlignmentCenter;
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}


/**
 *  摇一摇
 */
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake) {

    self.shakeLabel.text = @"开始摇一摇";
    }
}


- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake) {
        
    self.shakeLabel.text = @"摇一摇结束";
    }
}


- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake) {
        
    self.shakeLabel.text = @"取消摇一摇";
    }
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
