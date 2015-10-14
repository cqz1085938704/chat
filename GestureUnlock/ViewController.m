//
//  ViewController.m
//  GestureUnlock
//
//  Created by Henry on 15/5/11.
//  Copyright (c) 2015年 Henry. All rights reserved.
//

#import "ViewController.h"
#import "Chats.h"
#import "DetailViewController.h"

#define WIN_SIZE [UIScreen mainScreen].bounds.size

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *results;
    UITableView *tableV;
    DetailViewController *detailVC;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIN_SIZE.width, WIN_SIZE.height) style:UITableViewStylePlain];
    tableV.delegate = self;
    tableV.dataSource = self;
    [self.view addSubview:tableV];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 80, 28);
    [btn setTitle:@"退出" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    btn.center = self.view.center;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSInteger unreadCount = 0;
    for (Chats *chat in results)
    {
        for (Message *msg in chat.messages)
        {
            if (!msg.bRead)
            {
                unreadCount += 1;
            }
        }
    }
    
    if (unreadCount != 0)
    {
        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%li", (long)unreadCount];
    }
}

-(void)buttonClicked:(UIButton *)sender
{
    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user_id"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    results = [NSMutableArray arrayWithCapacity:1];
}

-(void)updateUI:(NSDictionary *)userInfo
{
    NSString *idStr = userInfo[@"id"];
    NSString *text = userInfo[@"aps"][@"alert"];
    
    Message *message = [[Message alloc] init];
    message.text = text;
    message.bRead = NO;
    
    BOOL needCreateNew = YES;
    for (Chats *chat in results)
    {
        if ([chat.chatId isEqualToString:idStr])
        {
            [chat.messages addObject:message];
            
            needCreateNew = NO;
            
            
            if (detailVC && detailVC.chat == chat)
            {
                [detailVC newMsgComs];
            }
            
            break;
        }
    }
    
    if (needCreateNew)
    {
        Chats *newChat = [[Chats alloc] init];
        newChat.chatId = idStr;
        [newChat.messages addObject:message];
        [results addObject:newChat];
    }
    
    [tableV reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return results.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [[cell viewWithTag:111] setHidden:YES];
    
    DetailViewController *d = [[DetailViewController alloc] initWithStyle:UITableViewStylePlain];
    detailVC = d;
    
    Chats *chat = results[indexPath.row];
    d.chat = chat;
    [self.navigationController pushViewController:d animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        label.center = CGPointMake(cell.frame.size.width - 25, 40);
        label.layer.cornerRadius = 10;
        label.layer.backgroundColor = [UIColor redColor].CGColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.tag = 111;
        label.hidden = YES;
        [cell addSubview:label];
    }
    
    Chats *chat = results[indexPath.row];
    
    UILabel *label = (UILabel *)[cell viewWithTag:111];
    
    if (chat.messages.count > 0)
    {
        label.hidden = NO;
        label.text = [NSString stringWithFormat:@"%lu", (unsigned long)chat.messages.count];
        
        CGSize size = [label.text boundingRectWithSize:CGSizeMake(WIN_SIZE.width, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        label.frame = CGRectMake(0, 0, size.width, 20);
        label.center = CGPointMake(WIN_SIZE.width - 25, 40);
    }
    else
    {
        label.hidden = YES;
    }
    
    cell.textLabel.text = [chat.messages lastObject];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    results = nil;
    detailVC = nil;
    tableV = nil;
}

@end
