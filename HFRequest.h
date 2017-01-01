//
//  HFRequest.h
//  HFConnection
//
//  Created by  LiQiu Yu on 15-9-28.
//  Copyright (c) 2015年 LiQiu Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

//for arc and non-arc
#ifndef LW_STRONG
#if __has_feature(objc_arc)
#define LW_STRONG strong
#else
#define LW_STRONG retain
#endif
#endif

#ifndef LW_WEAK
#if __has_feature(objc_arc_weak)
#define LW_WEAK weak
#elif __has_feature(objc_arc)
#define LW_WEAK unsafe_unretained
#else
#define LW_WEAK assign
#endif
#endif

#if __has_feature(objc_arc)
#define LW_AUTORELEASE(exp) exp
#define LW_RELEASE(exp) exp
#define LW_RETAIN(exp) exp
#else
#define LW_AUTORELEASE(exp) [exp autorelease]
#define LW_RELEASE(exp) [exp release]
#define LW_RETAIN(exp) [exp retain]
#endif

#define DELEGATE_TYPE 0
#define BLOCK_TYPE 1
#define NOT_SAVE 0
#define SAVE_TO_FILE 1

@class HFConnectionOpertation;
@class HFResponse;

@protocol HFConnectionDelegate;
typedef void(^didFinishBlock) (HFResponse *re);
typedef void(^inProgressBlock) (HFResponse *re);


@interface HFRequest : NSObject

@property (nonatomic, LW_STRONG) NSString *requestTarget;
@property (nonatomic, LW_STRONG) NSString *requestURL;
@property (nonatomic, LW_STRONG) NSMutableURLRequest*request;

@property (nonatomic,copy) didFinishBlock  finishBlock;
@property (nonatomic,copy) inProgressBlock  inprogressBlock;

@property (nonatomic) int callBackType;
@property (nonatomic) int persistentType;
@property (nonatomic, LW_WEAK) id<HFConnectionDelegate> delegate;


- (id)initWithTraget:(NSString *)target requestURL:(NSString *)url delegate:(id<HFConnectionDelegate>)delegate_;

- (id)initWithTraget:(NSString *)target requestURL:(NSString *)url isPersistance:(BOOL) isPer delegate:(id<HFConnectionDelegate>)delegate_;

- (id)initWithTarget:(NSString *)target requestURL:(NSString *)url isPersistance:(BOOL) isPer finishHandler:(didFinishBlock)finishBlock_ inProgressHandler:(inProgressBlock)progressBlock_;

- (id)initWithTarget:(NSString *)target requestURL:(NSString *)url isPersistance:(BOOL) isPer  delegate:(id<HFConnectionDelegate>)delegate_ finishHandler:(didFinishBlock)finishBlock_ inProgressHandler:(inProgressBlock)progressBlock_;

- (void)setFileOffSet:(unsigned long long) startOffset;

@end
