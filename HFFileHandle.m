//
//  HFFileHandle.m
//  HFConnetionDemo
//
//  Created by  LiQiu Yu on 15-9-28.
//  Copyright (c) 2015年 LiQiu Yu. All rights reserved.
//

#import "HFFileHandle.h"

@interface HFFileHandle ()
@property (nonatomic,LW_STRONG) NSFileManager *manager;
@property (nonatomic,LW_STRONG) NSFileHandle *writeFileHandle;
@property (nonatomic,LW_STRONG) NSFileHandle *readFileHandle;
@property (nonatomic,LW_STRONG) HFRequest *request;

@end

@implementation HFFileHandle
@synthesize manager;
@synthesize writeFileHandle;
@synthesize readFileHandle;
@synthesize request;
@synthesize doneFilePath;
@synthesize writingFilePath;

- (id)initWithRequest:(HFRequest*)re{
    self = [super init];
    if (self) {        
        self.request = re;
        [self setFilePathWithRequestURL:[request.request.URL absoluteString]];
        self.manager = [NSFileManager defaultManager];
    }
    return self;
}
- (void)dealloc{
    #if !__has_feature(objc_arc)
    [manager release];
    [request release];
    [writeFileHandle release];
    [readFileHandle release];
    [doneFilePath release];
    [writingFilePath release];
    [super dealloc];
    #endif
}

- (void)writeData:(NSData*)data{
    if (writeFileHandle) {
        [writeFileHandle writeData:data];
    }
}

- (void)closeFile{

    [readFileHandle closeFile];
    [writeFileHandle closeFile];
    [self fileDone:writingFilePath];
}


- (void) fileDone:(NSString *)path{

    self.doneFilePath = [path stringByAppendingPathExtension:@"done"];
    NSError *error;
    //file exist or not
    if ([manager fileExistsAtPath:doneFilePath]) {
        [manager removeItemAtPath:doneFilePath error:&error];
    }else{
        NSLog(@"file not exist at path %@",doneFilePath);
    }
    
    if ([manager moveItemAtPath:writingFilePath toPath:doneFilePath error:&error] ){
        
    }else{
        NSLog(@"file manger move error %@",error);
    }


}

- (NSString *)documentPath {
    return  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];;
}

- (void) setFilePathWithRequestURL:(NSString *)url {
    NSArray *urlcomponent = [url componentsSeparatedByString:@"/"];
    NSString *fileName = [urlcomponent lastObject];
    self.writingFilePath = [[self documentPath] stringByAppendingPathComponent:fileName];
    self.writeFileHandle = [NSFileHandle fileHandleForWritingAtPath:writingFilePath];
    [writeFileHandle seekToFileOffset:[self getStartOffSetWithPath]];

}
- (void)createFile{
    if (![[NSFileManager defaultManager] fileExistsAtPath:writingFilePath]) {
        [manager createFileAtPath:writingFilePath contents:nil attributes:nil];
    }
}

- (unsigned long long)getStartOffSetWithPath{
    if(writingFilePath)
    {
        if ([[NSFileManager defaultManager] fileExistsAtPath:writingFilePath]) {
            self.readFileHandle = [NSFileHandle fileHandleForReadingAtPath:writingFilePath];
            return [[readFileHandle readDataToEndOfFile] length];
        }
        else{
            //[manager createFileAtPath:_writingFilePath contents:nil attributes:nil];
        }
    }
    return 0;
}


@end
