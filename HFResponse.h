//
//  HFResponse.h
//  HFConnection
//
//  Created by  LiQiu Yu on 15-9-28.
//  Copyright (c) 2015年 LiQiu Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HFRequest.h"

@interface HFResponse : NSObject

@property (nonatomic, copy) NSString *responseTarget;
@property (nonatomic, LW_STRONG) NSData *responseData;
@property (nonatomic) int expectedSize;
@property (nonatomic, LW_STRONG) NSError *error;
@property (nonatomic) float downloadRate;
@property (nonatomic, LW_STRONG) NSURLResponse *response;


@end
