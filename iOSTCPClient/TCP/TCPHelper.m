//
//  TCPHelper.m
//  iOSTCPClient
//
//  Created by 吴湧霖 on 15/8/19.
//  Copyright (c) 2015年 吴湧霖. All rights reserved.
//

#import "TCPHelper.h"

@implementation TCPHelper

+ (NSData *)headerWithLength:(NSUInteger)length {
    unsigned char header[4];
    *(unsigned char*)(header + 0) = (unsigned char)((length >> 24) & 0xff);
    *(unsigned char*)(header + 1) = (unsigned char)((length >> 16) & 0xff);
    *(unsigned char*)(header + 2) = (unsigned char)((length >> 8) & 0xff);
    *(unsigned char*)(header + 3) = (unsigned char)((length >> 0) & 0xff);
    NSData *data = [NSData dataWithBytes:header length:4];
    return data;
}

+ (NSUInteger)lengthWithHeader:(NSData *)data {
    unsigned char header[4];
    [data getBytes:header length:4];
    NSUInteger length = ((unsigned int)(*(header + 0)) << 24) |
    ((unsigned int)(*(header + 1)) << 16) |
    ((unsigned int)(*(header + 2)) << 8) |
    ((unsigned int)(*(header + 3)) << 0);
    return length;
}

@end
