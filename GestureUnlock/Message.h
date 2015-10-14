//
//  Message.h
//  GestureUnlock
//
//  Created by Henry on 15/5/27.
//  Copyright (c) 2015年 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) BOOL bRead;

@end
