//
//  TCPHelper.h
//  iOSTCPClient
//
//  Created by 吴湧霖 on 15/8/19.
//  Copyright (c) 2015年 吴湧霖. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCPHelper : NSObject

+ (NSData *)headerWithLength:(NSUInteger)length;

+ (NSUInteger)lengthWithHeader:(NSData *)data;

@end
