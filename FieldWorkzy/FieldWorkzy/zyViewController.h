//
//  zyViewController.h
//  FieldWorkzy
//
//  Created by Zhaoyao on 14-11-13.
//  Copyright (c) 2014年 ZH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface zyViewController : UIViewController <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *Username;


- (IBAction)Username:(id)sender;



@property (weak, nonatomic) IBOutlet UITextField *UserPassword;


- (IBAction)UserPassword:(id)sender;



- (IBAction)Landed:(id)sender;




@property (weak, nonatomic) IBOutlet UIButton *RememberPassword;




- (IBAction)RememberPassword:(UIButton *)sender;


- (void)judgeAccount;


@end
