//
//  Logon_VC.h
//  GestureUnlock
//
//  Created by Henry on 15/7/13.
//  Copyright (c) 2015年 Henry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface Logon_VC : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

- (IBAction)handleLogon:(UIButton *)sender;

@end
