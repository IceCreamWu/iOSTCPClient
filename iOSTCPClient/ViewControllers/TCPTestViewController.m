//
//  TCPTestViewController.m
//  iOSTCPClient
//
//  Created by 吴湧霖 on 15/8/19.
//  Copyright (c) 2015年 吴湧霖. All rights reserved.
//

#import "TCPTestViewController.h"
#import "TCPManager.h"
#import "NetworkConfig.h"

@interface TCPTestViewController ()

@property(strong, nonatomic) UIButton *sendButton;

@end

@implementation TCPTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.sendButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"Send" forState:UIControlStateNormal];
        button.frame = CGRectMake(100, 100, 100, 75);
        button.backgroundColor = [UIColor blueColor];
        button.layer.cornerRadius = 5;
        [button addTarget:self action:@selector(sendHello) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self.view addSubview:self.sendButton];
}

- (void)sendHello {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"echoMsg"] = @"Hello!";
    TCPMessage *msg = [TCPMessage createTCPMessageWithSid:SID_COMMON cid:CID_ECHO data:dict];
    [[TCPManager sharedInstance] send:msg];
}

@end
