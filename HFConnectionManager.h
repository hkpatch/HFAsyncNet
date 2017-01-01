//
//  HFConnectionManager.h
//  HFConnection
//
//  Created by  LiQiu Yu on 15-9-28.
//  Copyright (c) 2015年 LiQiu Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HFRequest.h"
#import "HFResponse.h"
#import "HFConnectionOpertation.h"


#define MAX_CONCURRENT_OPERATION_COUNT 3

@interface HFConnectionManager : NSObject {
    NSOperationQueue *downloadQueue;
    int i;
}

+ (HFConnectionManager *)defaultManager;

- (void)setMaxConcurrentOperationCount:(int)max;

- (void)addRequest:(HFRequest *)reqeust;

- (HFResponse *)addSynchronizedReqeust:(HFRequest *)request;
@end
