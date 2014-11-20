//
//  zyRegisViewController.m
//  FieldWorkzy
//
//  Created by Zhaoyao on 14-11-13.
//  Copyright (c) 2014年 ZH. All rights reserved.
//

#import "zyRegisViewController.h"
#import "zyViewController.h"

@interface zyRegisViewController ()

@end

@implementation zyRegisViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return  YES;
    
}



- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    self.view.frame = [UIScreen mainScreen].bounds;
    
    CGRect frame = [UIScreen mainScreen].bounds;
    
    frame.origin.y -= 60;
    
    self.view.frame = frame;
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame = [UIScreen mainScreen].bounds;
    
    CGRect frame = [UIScreen mainScreen].bounds;
    
    frame.origin.y += 60;

    //    self.view.frame = frame;
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//  [self.view resignFirstResponder];

//}

- (IBAction)Name:(UITextField *)sender {
    
    //[self.Name resignFirstResponder];
    
}

- (IBAction)Telephone:(UITextField *)sender {
    
    //[self.Telephone resignFirstResponder];
    
}

- (IBAction)Password:(id)sender {
    
    //[self.Password resignFirstResponder];
    
}


- (IBAction)Confirm:(id)sender {
    
    //[self.Confirm resignFirstResponder];
    
}


- (IBAction)Finish:(id)sender {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://docs.maichong.it/waiqin/user/register.htm"]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //发送post请求
    [request setHTTPMethod:@"POST"];
    
    [request setTimeoutInterval:15];
    
    NSDictionary *dic = @{@"name":self.Name.text,@"telephone":self.Telephone.text,@"password":self.Password.text,@"confirm":self.Confirm.text};
    
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
    
    
}
@end
