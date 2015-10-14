//
//  Logon_VC.m
//  GestureUnlock
//
//  Created by Henry on 15/7/13.
//  Copyright (c) 2015年 Henry. All rights reserved.
//

#import "Logon_VC.h"

@implementation Logon_VC

- (IBAction)handleLogon:(UIButton *)sender
{
    if (self.userNameTF.text.length == 0)
    {
        return;
    }
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    [[NSUserDefaults standardUserDefaults] setObject:self.userNameTF.text forKey:@"user_id"];
    
    ViewController *vc = [[ViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}



-(void)viewDidAppear:(BOOL)animated
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"])
    {
        ViewController *vc = [[ViewController alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }
}
@end
