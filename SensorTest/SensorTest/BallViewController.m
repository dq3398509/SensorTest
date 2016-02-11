//
//  BallViewController.m
//  SensorTest
//
//  Created by 董强 on 15/12/7.
//  Copyright © 2015年 董强. All rights reserved.
//

#import "BallViewController.h"

@interface BallViewController ()<UIAccelerometerDelegate>


@property (strong, nonatomic)  UIImageView *backImageView;
@property (nonatomic, strong) UIImageView *ball;
@property (assign, nonatomic) CGPoint volecity;

@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn3;

@property (nonatomic, strong) UIView *ban;


@end

@implementation BallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.tabBarController.tabBar.hidden = YES;
    
    
    self.backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"69dab1b00580d68cd3eb08d5c204b341"]];
    self.backImageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:self.backImageView];
    
    
    self.ball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"未标题-1"]];
    self.ball.frame = CGRectMake(0, 0, 50, 50);
    self.ball.center = self.view.center;
    NSLog(@"%f", self.view.center.x);
    [self.view addSubview:self.ball];
    
    
    
    // 背景
    self.ban = [[UIView alloc] init];
    self.ban.frame = CGRectMake(0, 0, 200, 200);
    [self.view addSubview:self.ban];
    self.ban.center = self.view.center;
    
    
    /**
     毛玻璃图
     */
    UIVisualEffectView *visurl = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    visurl.frame = CGRectMake(0, 0, 200, 200);
    [self.ban addSubview:visurl];

    
    
    
    
    // 菜单
    UILabel *tit = [[UILabel alloc] init];
    tit.text = @"菜单";
    tit.frame = CGRectMake(0, 0, 120, 30);
    tit.center = CGPointMake(self.ban.frame.size.width / 2 + 43, self.ban.frame.size.height / 2 - 70);
    [self.ban addSubview:tit];
    
    // 继续游戏
    self.btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.ban addSubview:self.btn1];
    [self.btn1 setTitle:@"恢复" forState:UIControlStateNormal];
    self.btn1.frame = CGRectMake(0, 0, 50, 50);
    [self.btn1 addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    self.btn1.center = CGPointMake(self.ban.frame.size.width / 2, self.ban.frame.size.height / 2);
    
    
    // 返回
    self.btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.ban addSubview:self.btn2];
    [self.btn2 setTitle:@"返回" forState:UIControlStateNormal];
    self.btn2.frame = CGRectMake(0, 0, 50, 50);
    [self.btn2 addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.btn2.center = CGPointMake(self.ban.frame.size.width / 2, self.ban.frame.size.height / 2 + 70);
    
    self.ban.hidden = YES;
    

    
    
    
    //获得单例对象
    UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
    //设置代理
    accelerometer.delegate = self;
    //设置采样间隔 1/60.0 就是 1秒采集60次
    accelerometer.updateInterval = 1 / 60.0;

}


- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    
    // 位移=速度*时间=加速度*时间*时间
    
    _volecity.x += acceleration.x;
    _volecity.y -= acceleration.y;
    
  
    
    CGFloat aaa = self.ball.center.x;
    aaa += self.volecity.x;
    
    CGFloat bbb = self.ball.center.y;
    bbb += self.volecity.y;
    
    
    self.ball.center = CGPointMake(aaa, bbb);
    
    
    if(self.ball.center.x <= 25){
        self.ball.center = CGPointMake(25, self.ball.center.y);
    }
    if (self.ball.center.y <= 25) {
        self.ball.center = CGPointMake(self.ball.center.x, 25);
    }
    if (self.ball.center.x>=self.view.bounds.size.width -25) {
        self.ball.center = CGPointMake(self.view.bounds.size.width - 25, self.ball.center.y);
    }
    if (self.ball.center.y>=self.view.bounds.size.height - 25) {
        self.ball.center = CGPointMake(self.ball.center.x, self.view.bounds.size.height - 25);
    }
    
    
    
    //边界检测
    if(self.ball.center.x<=25){
        self.ball.center = CGPointMake(25, self.ball.center.y);
        //加入反弹，削弱速度
        _volecity.x *= -0.5;
    }
    if (self.ball.center.y <=25) {
        self.ball.center = CGPointMake(self.ball.center.x, 25);
        _volecity.y *= -0.5;
    }
    if (self.ball.center.x >= self.view.bounds.size.width - 25) {
        self.ball.center = CGPointMake(self.view.bounds.size.width - 25, self.ball.center.y);
        _volecity.x *= -0.5;
    }
    if (self.ball.center.y >=self.view.bounds.size.height - 25) {
        self.ball.center = CGPointMake(self.ball.center.x, self.view.bounds.size.height - 25);
        _volecity.y *= -0.5;
    }


}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.ban.hidden = NO;

}


- (void)go:(UIButton *)btn {
    
    self.ban.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)back:(UIButton *)btn {
    
    self.tabBarController.tabBar.hidden = NO;
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
