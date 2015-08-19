//
//  TCPManager.m
//  iOSTCPClient
//
//  Created by 吴湧霖 on 15/8/19.
//  Copyright (c) 2015年 吴湧霖. All rights reserved.
//

#import "TCPManager.h"
#import "TCPClient.h"
#import "NetworkConfig.h"

@interface TCPManager ()<TCPClientDelegate>

@property (strong, nonatomic) TCPClient *client;
@property(strong, nonatomic) NSTimer *keepAliveTimer;

@end

@implementation TCPManager

+ (instancetype)sharedInstance {
    static TCPManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TCPManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _client = [[TCPClient alloc] init];
        _client.delegate = self;
        [_client connect];
    }
    return self;
}

- (void)send:(TCPMessage *)message {
    NSError *error;
    NSData *sendData = [message parseToData:error];
    if (error != nil) {
        NSLog(@"Send Error: %@", error);
    } else {
        [self.client send:sendData];
    }
}

- (void)sendKeepAlive {
    TCPMessage *aliveMsg = [TCPMessage createTCPMessageWithSid:SID_COMMON cid:CID_ALIVE data:nil];
    [self send:aliveMsg];
}

#pragma mark - TCPClientDelegate
- (void)didConnectSuccess {
    self.keepAliveTimer = [NSTimer scheduledTimerWithTimeInterval:NETWORK_TCP_ALIVE_INTERVAL target:self selector:@selector(sendKeepAlive) userInfo:nil repeats:YES];
}

- (void)didDisconnect {
    [self.keepAliveTimer invalidate];
}

@end
