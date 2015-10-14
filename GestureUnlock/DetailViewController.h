//
//  DetailViewController.h
//  GestureUnlock
//
//  Created by Henry on 15/5/21.
//  Copyright (c) 2015年 Henry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Chats.h"
#import "Message.h"

@interface DetailViewController : UITableViewController

@property (nonatomic, strong) Chats *chat;

-(void)newMsgComs;

@end
