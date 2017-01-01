//
//  MyRequest.m
//  MultDownloader
//
//  Created by  LiQiu Yu on 15-9-28.
//  Copyright (c) 2015年 LiQiu Yu. All rights reserved.
//

#import "HFRequest.h"

@interface HFRequest()

@end

@implementation HFRequest

@synthesize requestTarget;
@synthesize request;
@synthesize requestURL;
@synthesize delegate;
@synthesize finishBlock;
@synthesize inprogressBlock;
@synthesize callBackType;
@synthesize persistentType;

- (id)init {
    self = [super init];
    if (self) {
        request = [[NSMutableURLRequest alloc] init];
        callBackType = BLOCK_TYPE;
        persistentType = NOT_SAVE;
    }
    return self;
}

- (void)dealloc{
    #if !__has_feature(objc_arc)
    [requestTarget release];
    [requestURL release];
    [request release];
    [finishBlock release];
    [inprogressBlock release];
    [super dealloc];
    #endif
}

- (id)initWithTraget:(NSString *)target requestURL:(NSString *)url delegate:(id<HFConnectionDelegate>)delegate_{

        return [self initWithTarget:target requestURL:url isPersistance:NO delegate:delegate_ finishHandler:nil inProgressHandler:nil];
}

- (id)initWithTraget:(NSString *)target requestURL:(NSString *)url isPersistance:(BOOL) isPer delegate:(id<HFConnectionDelegate>)delegate_
{
    return [self initWithTarget:target requestURL:url isPersistance:isPer delegate:delegate_ finishHandler:nil inProgressHandler:nil];
}


- (id)initWithTarget:(NSString *)target requestURL:(NSString *)url isPersistance:(BOOL) isPer finishHandler:(didFinishBlock)finishBlock_ inProgressHandler:(inProgressBlock)progressBlock_
{
    return [self initWithTarget:target requestURL:url isPersistance:isPer delegate:nil finishHandler:finishBlock_ inProgressHandler:progressBlock_];
}

- (id)initWithTarget:(NSString *)target requestURL:(NSString *)url isPersistance:(BOOL) isPer  delegate:(id<HFConnectionDelegate>)delegate_ finishHandler:(didFinishBlock)finishBlock_ inProgressHandler:(inProgressBlock)progressBlock_{
    self = [super init];
    if (self) {
        request = [[NSMutableURLRequest alloc] init];
        request.URL = [NSURL URLWithString:url];
        if (isPer) {
            persistentType = SAVE_TO_FILE;
        }else{
            persistentType = NOT_SAVE;
        }
        self.requestTarget = target;
        
        if (delegate_) {
            delegate = delegate_;
            callBackType = DELEGATE_TYPE;
        }
        else {
            self.finishBlock = finishBlock_;
            self.inprogressBlock = progressBlock_;
            callBackType = BLOCK_TYPE;
        }
    }
    return self;
}


- (void)setFileOffSet:(unsigned long long) startOffset {
    NSString *rangeValue = [NSString stringWithFormat:@"bytes=%llu-",startOffset];
    [request setValue:rangeValue forHTTPHeaderField:@"Range"];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"requets url is %@, header is %@",request.URL.absoluteString, [request allHTTPHeaderFields]];
}



@end
