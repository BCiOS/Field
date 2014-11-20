//
//  zyRegisViewController.h
//  FieldWorkzy
//
//  Created by Zhaoyao on 14-11-13.
//  Copyright (c) 2014年 ZH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface zyRegisViewController : UIViewController

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

@property (weak, nonatomic) IBOutlet UITextField *Name;


@property (weak, nonatomic) IBOutlet UITextField *Telephone;


@property (weak, nonatomic) IBOutlet UITextField *Password;


@property (weak, nonatomic) IBOutlet UITextField *Confirm;


- (IBAction)Name:(UITextField *)sender;



- (IBAction)Telephone:(UITextField *)sender;



- (IBAction)Password:(id)sender;



- (IBAction)Confirm:(id)sender;



- (IBAction)Finish:(id)sender;








@end
