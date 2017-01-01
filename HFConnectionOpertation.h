//
//  HFConnectionOperation.h
//  HFConnection
//
//  Created by  LiQiu Yu on 15-9-28.
//  Copyright (c) 2015年 LiQiu Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HFRequest.h"
#import "HFResponse.h"
#import "HFFileHandle.h"

@protocol HFConnectionDelegate;
@class HFRequest;
@class HFFileHandle;

@protocol HFConnectionDelegate <NSObject>

- (void)downloadFinished:(HFResponse *)response;
- (void)downloadInprogress:(HFResponse *)response;

@end

@interface HFConnectionOpertation : NSOperation {
    
    NSURLConnection *connection;
    NSMutableData *responseData;
    BOOL isFinished;
    unsigned long long startOffset;
    HFFileHandle *fileHandle;
    
}

@property (nonatomic, LW_STRONG) HFRequest *request;
@property (nonatomic, LW_STRONG) HFResponse *response;
@property (nonatomic, LW_WEAK) NSObject <HFConnectionDelegate> *delegate;



- (id)initWithRequest:(HFRequest *)request_;

@end


