//
//  TCPClient.h
//  iOSTCPClient
//
//  Created by 吴湧霖 on 15/8/19.
//  Copyright (c) 2015年 吴湧霖. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TCPClientDelegate <NSObject>

@optional
- (void)didConnectSuccess;

@optional
- (void)didDisconnect;

@optional
- (void)didReadData:(NSData *)data;

@end

@interface TCPClient : NSObject

@property(assign, nonatomic) id<TCPClientDelegate> delegate;

- (void)connect;

- (void)send:(NSData *)data;

@end
