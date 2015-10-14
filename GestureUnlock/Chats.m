//
//  Chats.m
//  GestureUnlock
//
//  Created by Henry on 15/5/21.
//  Copyright (c) 2015年 Henry. All rights reserved.
//

#import "Chats.h"

@implementation Chats

-(instancetype)init
{
    if (self = [super init])
    {
        _messages = [NSMutableArray arrayWithCapacity:1];
    }
    return self;
}

@end
