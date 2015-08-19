//
//  TCPMessage.h
//  iOSTCPClient
//
//  Created by 吴湧霖 on 15/8/19.
//  Copyright (c) 2015年 吴湧霖. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCPMessage : NSObject

+ (TCPMessage *)createTCPMessageWithSid:(NSUInteger)sid cid:(NSUInteger)cid data:(NSDictionary *)data;

- (NSData *)parseToData:(NSError *)error;

@end
