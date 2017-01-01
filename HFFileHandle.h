//
//  HFFileHandle.h
//  HFConnection
//
//  Created by  LiQiu Yu on 15-9-28.
//  Copyright (c) 2015年 LiQiu Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HFRequest.h"

@class HFRequest;

@interface HFFileHandle : NSObject{
    

}
@property (nonatomic,copy) NSString *doneFilePath;
@property (nonatomic,copy) NSString *writingFilePath;


- (unsigned long long)getStartOffSetWithPath;
- (id)initWithRequest:(HFRequest*)re;
- (void)createFile;
- (void)writeData:(NSData*)data;
- (void)closeFile;
@end
