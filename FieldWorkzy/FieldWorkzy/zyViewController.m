//
//  zyViewController.m
//  FieldWorkzy
//
//  Created by Zhaoyao on 14-11-13.
//  Copyright (c) 2014年 ZH. All rights reserved.
//  测试 test   test  test

#import "zyViewController.h"



@interface zyViewController ()

@end

@implementation zyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.RememberPassword.selected = [defaults boolForKey:@"selected"];
    
    self.Username.text = [defaults objectForKey:@"password"];
    self.UserPassword.text = [defaults objectForKey:@"username"];
    
}

/**
 *  点击空白处隐藏键盘隐藏键盘
 *
 *  @param touches
 *  @param event
 */
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event

{
    [self.view endEditing:YES];
}
  


- (IBAction)Username:(id)sender {
    
    //[self.Username resignFirstResponder];
    
}

- (IBAction)UserPassword:(id)sender {
    
    //[self.UserPassword resignFirstResponder];
    
}


- (IBAction)Landed:(id)sender {
    //判断账号
    [self judgeAccount];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://outworker.maichong.it/api/user/login"]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //发送post请求
    [request setHTTPMethod:@"POST"];
    
    [request setTimeoutInterval:15];
    
    NSDictionary *dic = @{@"username":self.Username.text,@"password":self.UserPassword.text};
    
    //将字典转化成数据包
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *jsondata = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //    NSLog(@"jsondata = %@",jsondata);
    
    [request setHTTPBody:[jsondata dataUsingEncoding:NSUTF8StringEncoding]];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if([data length]>0 && error == nil)
        {
            NSMutableDictionary * josnDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"josnDic = %@",josnDic);
            
            
        }
    }];
    

    
    //判断记住密码按钮的状态，存储账号信息
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:@"selected"]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        //存账号密码
        [defaults setObject:self.Username.text forKey:@"username"];
        [defaults setObject:self.UserPassword.text forKey:@"password"];
        
        //同步数据
        [defaults synchronize];
    }
  
    
}


- (void)judgeAccount
{
    if (self.Username.text.length == 0) {
        // 弹框提醒
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录失败" message:@"请输入账号" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    if (self.UserPassword.text.length == 0) {
        //弹框提醒
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录失败" message:@"请输入密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

- (IBAction)RememberPassword:(UIButton *)sender
{
    
   
    self.RememberPassword = sender;
    
    self.RememberPassword.selected = !self.RememberPassword.selected;
    
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        //按钮状态
        [defaults setBool:self.RememberPassword.selected forKey:@"selected"];
        //同步数据
        [defaults synchronize];
    

    
    
}

//
//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    
//    return  YES;
//}


/*- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    self.view.frame = [UIScreen mainScreen].bounds;
    
    CGRect frame = [UIScreen mainScreen].bounds;
    
    frame.origin.y -= 60;
    
    self.view.frame = frame;
    
}
 
 很多iOS应用都支持偏好设置，比如保存用户名、密码、字体大小等设置，iOS提供了一套标准的解决方案来为应用加入偏好设置功能
 
 每个应用都有个NSUserDefaults实例，通过它来存取偏好设置
 
 比如，保存用户名、字体大小、是否自动登录
 
 NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
 
 [defaults setObject:@"itcast" forKey:@"username"];
 
 [defaults setFloat:18.0f forKey:@"text_size"];
 
 [defaults setBool:YES forKey:@“auto_login"];
 
 
 读取上次保存的设置
 
 NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
 
 NSString *username = [defaults stringForKey:@"username"];
 
 float textSize = [defaults floatForKey:@"text_size"];
 
 BOOL autoLogin = [defaults boolForKey:@"auto_login"];
 
 
 注意：UserDefaults设置数据时，不是立即写入，而是根据时间戳定时地把缓存中的数据写入本地磁盘。所以调用了set方法之后数据有可能还没有写入磁盘应用程序就终止了。出现以上问题，可以通过调用synchornize方法强制写入
 
 [defaults synchornize];
 
 
 
       密码保存源代码
 
 NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
 //保存账号
 
 if (RememberPasswordButton.selected) {
 
 [userDefaults setBool:YES forKey:@"RememberPassword"];
 
 if (loginType == 2) {
 [userDefaults setObject:UserNameTextField.text forKey:@"USERNAME"];
 [userDefaults setObject:passWordTextField.text forKey:@"PASSWORD"];
 
 }
 else {
 [userDefaults setObject:UserNameTextField.text forKey:@"username"];
 [userDefaults setObject:passWordTextField.text forKey:@"password"];
 }
 
 
 }
 else {
 
 
 if (loginType == 2) {
 [userDefaults setObject:@"" forKey:@"USERNAME"];
 [userDefaults setObject:@"" forKey:@"PASSWORD"];
 
 }
 else {
 
 [userDefaults setObject:@"" forKey:@"username"];
 [userDefaults setObject:@"" forKey:@"password"];
 
 }
 
 
 [userDefaults setBool:NO forKey:@"RememberPassword"];
 
 }
 [userDefaults synchronize];
 
 [[NSOperationQueue mainQueue] addOperationWithBlock:^{
 
 [self dismissViewControllerAnimated:YES completion:nil];
 
 }];
 }
 else {
 
 [[NSOperationQueue mainQueue] addOperationWithBlock:^{
 
 SHOWAlertView(josnDic[@"msg"]);
 
 }];
 }
 
 }
 else
 {
 SHOWAlertView(@"请链接网络后再试！");
 }
 }];
 
 
 
 
 
 #import <UIKit/UIKit.h>
 #import <CoreLocation/CoreLocation.h>
 
 @interface ViewController : UIViewController<CLLocationManagerDelegate> {
 CLLocationManager* locationManager;
 }
 
 @property (strong, nonatomic)    CLLocationManager* locationManager;
 @property (retain, nonatomic) IBOutlet UILabel *longitudeText;
 @property (retain, nonatomic) IBOutlet UILabel *latituduText;
 @property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activity;
 - (IBAction)findMe:(id)sender;
 - (IBAction)webMap:(id)sender;
 
 @end
 
 CLLocationManagerDelegate是定位服务的委托，常用的位置变化回调方法是：
 
 locationManager:didUpdateToLocation:fromLocation: locationManager:didFailWithError:
 
 CLLocationManager 是定位服务管理类，通过它可以设置定位服务的参数、获取经纬度等。
 
 m中加载方法
 
 
 
 - (IBAction)findMe:(id)sender {
 self.locationManager = [[[CLLocationManager alloc] init] autorelease];
 self.locationManager.delegate = self;
 self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
 self.locationManager.distanceFilter = 1000.0f;
 [self.locationManager startUpdatingLocation];
 [activity startAnimating];
 NSLog(@"start gps");
 }
 
 
 
 
 CLLocationManager 是的startUpdatingLocation方法启动所有定位硬件，对应的方法是stopUpdatingLocation，通过调用该方法关闭定位服务器更新，为了省电必须在不用的时候调用该方法关闭定位服务。
 
 此外，我们还可以在这里设定定位服务的参数，包括：distanceFilter和desiredAccuracy。
 
 distanceFilter，这个属性用来控制定位服务更新频率。单位是“米”。 desiredAccuracy，这个属性用来控制定位精度，精度
 
 越高耗电量越大。
 
 定位精度
 
 desiredAccuracy精度参数可以iOS SDK通过常量实现：
 
 kCLLocationAccuracyNearestTenMeters，10米
 
 kCLLocationAccuracyHundredMeters ，100米
 
 kCLLocationAccuracyKilometer ，1000米
 
 kCLLocationAccuracyThreeKilometers，3000米
 
 kCLLocationAccuracyBest ，最好的精度
 
 kCLLocationAccuracyBestForNavigation，导航情况下最好精度，iOS 4 SDK新增加。一般要有外接电源时候才能使用。
 
 委托方法用于实现位置的更新
 
 
 
 
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame = [UIScreen mainScreen].bounds;
    
    CGRect frame = [UIScreen mainScreen].bounds;
    
    frame.origin.y += 60;
//    
//    self.view.frame = frame;
    
}*/



@end
