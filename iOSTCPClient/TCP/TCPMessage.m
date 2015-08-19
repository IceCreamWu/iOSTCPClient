//
//  TCPMessage.m
//  iOSTCPClient
//
//  Created by 吴湧霖 on 15/8/19.
//  Copyright (c) 2015年 吴湧霖. All rights reserved.
//

#import "TCPMessage.h"

@interface TCPMessage ()

@property(strong, nonatomic) NSMutableDictionary *dataDict;

@end

@implementation TCPMessage

+ (TCPMessage *)createTCPMessageWithSid:(NSUInteger)sid cid:(NSUInteger)cid data:(NSDictionary *)data {
    TCPMessage *msg = [[TCPMessage alloc] init];
    msg.dataDict = [[NSMutableDictionary alloc] initWithDictionary:data];
    msg.dataDict[@"sid"] = [NSNumber numberWithUnsignedInteger:sid];
    msg.dataDict[@"cid"] = [NSNumber numberWithUnsignedInteger:cid];
    return msg;
}

- (NSData *)parseToData:(NSError *)error {
    NSData *data = [NSJSONSerialization dataWithJSONObject:self.dataDict options:NSJSONWritingPrettyPrinted error:&error];
    return data;
}

@end
