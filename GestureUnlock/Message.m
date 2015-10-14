//
//  Message.m
//  GestureUnlock
//
//  Created by Henry on 15/5/27.
//  Copyright (c) 2015年 Henry. All rights reserved.
//

#import "Message.h"

@implementation Message

-(instancetype)init
{
    if (self = [super init])
    {
        _bRead = NO;
        _text = nil;
    }
    return self;
}

@end
