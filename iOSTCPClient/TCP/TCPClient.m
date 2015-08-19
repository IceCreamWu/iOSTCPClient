//
//  TCPClient.m
//  iOSTCPClient
//
//  Created by 吴湧霖 on 15/8/19.
//  Copyright (c) 2015年 吴湧霖. All rights reserved.
//

#import "TCPClient.h"
#import "TCPHelper.h"
#import "NetworkConfig.h"
#import <CocoaAsyncSocket/GCDAsyncSocket.h>

@interface TCPClient ()<GCDAsyncSocketDelegate>

@property(strong, nonatomic) GCDAsyncSocket *socket;

@end

@implementation TCPClient

- (instancetype)init
{
    self = [super init];
    if (self) {
        _socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return self;
}

- (void)connect {
    NSError *error = nil;
    if (![self.socket connectToHost:NETWORK_TCP_SERVER_HOST onPort:NETWORK_TCP_SERVER_PORT error:&error]) {
        NSLog(@"Error: %@", error);
    }
}

- (void)send:(NSData *)data {
    NSMutableData *sendData = [[NSMutableData alloc] init];
    [sendData appendData:[TCPHelper headerWithLength:[data length]]];
    [sendData appendData:data];
    [self.socket writeData:sendData withTimeout:-1 tag:0];
}

#pragma mark - GCDAsyncSocketDelegate
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    NSLog(@"Connect Success");
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didConnectSuccess)]) {
        [self.delegate didConnectSuccess];
    }
    [self.socket readDataToLength:NETWORK_TCP_HEADER_SIZE withTimeout:-1 tag:NETWORK_TCP_TAG_HEADER];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    NSLog(@"Connect Disconnect: %@", err);
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didDisconnect)]) {
        [self.delegate didDisconnect];
    }
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf connect];
    });
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    if (tag == NETWORK_TCP_TAG_HEADER) {
        NSUInteger length = [TCPHelper lengthWithHeader:data];
        [self.socket readDataToLength:length withTimeout:-1 tag:NETWORK_TCP_TAG_BODY];
    } else if (tag == NETWORK_TCP_TAG_BODY) {
        NSLog(@"Read Data: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didReadData:)]) {
            [self.delegate didReadData:data];
        }
        [self.socket readDataToLength:NETWORK_TCP_HEADER_SIZE withTimeout:-1 tag:NETWORK_TCP_TAG_HEADER];
    }
}

@end
