//
//  MyResponse.m
//  MultDownloader
//
//  Created by  LiQiu Yu on 15-9-28.
//  Copyright (c) 2015年 LiQiu Yu. All rights reserved.
//

#import "HFResponse.h"

@implementation HFResponse

@synthesize responseTarget;
@synthesize responseData;
@synthesize expectedSize;
@synthesize error;
@synthesize downloadRate;
@synthesize response;


- (id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc{
    #if !__has_feature(objc_arc)
    [responseTarget release];
    [responseData release];
    [error release];
    [response release];
    [super dealloc];
    #endif
}


@end
