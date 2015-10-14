//
//  Chats.h
//  GestureUnlock
//
//  Created by Henry on 15/5/21.
//  Copyright (c) 2015年 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"

@interface Chats : NSObject

@property (nonatomic, copy)NSString * chatId;
@property (nonatomic, strong)NSMutableArray *messages;

@end
