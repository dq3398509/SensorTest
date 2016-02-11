//
//  AppDelegate.m
//  SensorTest
//
//  Created by 董强 on 15/12/5.
//  Copyright © 2015年 董强. All rights reserved.
//

#import "AppDelegate.h"
#import "AccelerometerVC.h"
#import "MagnetometerVC.h"
#import "CameraVC.h"
#import "BallViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    
    AccelerometerVC *accele = [[AccelerometerVC alloc] init];
    accele.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"加速计" image:[[UIImage alloc] init] tag:100];
    
    MagnetometerVC *magnet = [[MagnetometerVC alloc] init];
    magnet.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"指南针" image:[[UIImage alloc] init] tag:200];
    
    CameraVC *camera = [[CameraVC alloc] init];
    camera.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"相机" image:[[UIImage alloc] init] tag:300];
    
    BallViewController *ball = [[BallViewController alloc] init];
    ball.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Ball" image:[[UIImage alloc] init] tag:400];
    
    UITabBarController *tabbarCon = [[UITabBarController alloc ] init];
    
    tabbarCon.viewControllers = @[accele, magnet, camera, ball];
    
    tabbarCon.selectedIndex = 0;
    
    tabbarCon.tabBar.tintColor = [UIColor colorWithRed:0.400 green:0.800 blue:1.000 alpha:1.000];
    

    
    
    self.window.rootViewController = tabbarCon;
    
    
    // 不黑屏
    UIApplication *app = [UIApplication sharedApplication];
    app.idleTimerDisabled = YES;
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
