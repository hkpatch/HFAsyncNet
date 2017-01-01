//
//  DownladerManager.m
//  MultDownloader
//
//  Created by  LiQiu Yu on 15-9-28.
//  Copyright (c) 2015年 LiQiu Yu. All rights reserved.
//

#import "HFConnectionManager.h"
#import "HFConnectionOpertation.h"

@interface HFConnectionManager ()

@end

@implementation HFConnectionManager

static HFConnectionManager *instance;



+ (HFConnectionManager *)defaultManager {
    if (!instance) {
        instance = [[self alloc] init];
    }
 
    return instance;
}

- (id)init {
    if (self = [super init]) {
        downloadQueue = [[NSOperationQueue alloc] init];
        downloadQueue.maxConcurrentOperationCount = MAX_CONCURRENT_OPERATION_COUNT;
        i = 0;
    }
    return self;
}

- (void)dealloc{
#if !__has_feature(objc_arc)
    [downloadQueue release];
    [super dealloc];
#endif
}

- (void)setMaxConcurrentOperationCount:(int)max{
    if (max >0) {
        downloadQueue.maxConcurrentOperationCount = max;
    }
}

- (void)addRequest:(HFRequest *)reqeust {
    HFConnectionOpertation *downloader = LW_AUTORELEASE([[HFConnectionOpertation alloc] initWithRequest:reqeust]);
    [downloadQueue addOperation:downloader];
    i ++;
}

- (HFResponse *)addSynchronizedReqeust:(HFRequest *)request{
    NSError *error;
    NSURLResponse *response;
    NSData *data= [NSURLConnection sendSynchronousRequest:request.request returningResponse:&response error:&error];
    HFResponse *re = [[HFResponse alloc]init];
    re.response = response;
    re.responseData = data;
    re.error = error;
    re.responseTarget = request.requestTarget;
    return re;
}



@end
