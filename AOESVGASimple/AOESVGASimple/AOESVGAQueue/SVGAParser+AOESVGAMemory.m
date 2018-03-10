//
//  SVGAParser+AOESVGAMemory.m
//  AOESVGASimple
//
//  Created by 夏宁忠 on 2018/3/9.
//  Copyright © 2018年 夏宁忠. All rights reserved.
//

#import "SVGAParser+AOESVGAMemory.h"
#import <CommonCrypto/CommonDigest.h>

@implementation SVGAParser (AOESVGAMemory)

-(void)parseMemoryWithURL:(NSURL *)URL Version:(NSString * _Nullable)version completionBlock:(void (^ _Nonnull)(SVGAVideoEntity * _Nullable))completionBlock failureBlock:(void (^ _Nullable)(NSError * _Nullable))failureBlock{
    
    NSFileManager * fileMgr = [NSFileManager defaultManager];
    
    NSString *dir = [self memorySVGADir:URL];
    NSString * svgaFilePath = [dir stringByAppendingString:[NSString stringWithFormat:@"/%@.svga",[self MD5StringExt:URL.absoluteString]]];
    NSString * versionFilePath = [dir stringByAppendingString:@"/version.text"];
    
    if ([fileMgr fileExistsAtPath:svgaFilePath]) { //存在
        
        //检测版本文件是否存在，如果存在version文件 对比version
        if ([fileMgr fileExistsAtPath:versionFilePath]) {
            
            NSString * versionStr = [NSString stringWithContentsOfFile:versionFilePath encoding:NSUTF8StringEncoding error:nil];
            if ([versionStr isEqualToString:version]) {
                
                //读取本地
                NSURL * locationUrl = [NSURL fileURLWithPath:svgaFilePath];
                [self parseWithURL:locationUrl completionBlock:^(SVGAVideoEntity * _Nullable videoItem) {
                    
                    if (completionBlock) {
                        
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            
                            completionBlock(videoItem);
                        }];
                    }
                    
                } failureBlock:^(NSError * _Nullable error) {
                    
                    if (failureBlock) {
                        
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            
                            failureBlock(error);
                        }];
                    }
                }];
  
            }else{ //版本不一致
                
                //重新下载然后加载
                //不存在version文件 重新下载svga，并创建version文件 写入版本号
                [[[NSURLSession sharedSession] dataTaskWithURL:URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    if (error == nil && data != nil) {
                        
                        [self parseWithURL:URL completionBlock:^(SVGAVideoEntity * _Nullable videoItem) {
                            
                            if (completionBlock) {
                                
                                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                    
                                    completionBlock(videoItem);
                                }];
                            }
                            
                        } failureBlock:^(NSError * _Nullable error) {
                            
                            if (failureBlock) {
                                
                                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                    
                                    failureBlock(error);
                                }];
                            }
                        }];
                        
                        //svga写入文件
                        [data writeToFile:svgaFilePath atomically:YES];
                        
                        //版本写入文件
                        NSString * svga_version = (version && ![version isEqualToString:@""]) ? version : @"0";
                        [svga_version writeToFile:versionFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
                        
                    }else {
                        if (failureBlock) {
                            
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                failureBlock(error);
                            }];
                        }
                    }
                }] resume];
            }
        }else{
            
            //不存在version文件 重新下载svga，并创建version文件 写入版本号
            [[[NSURLSession sharedSession] dataTaskWithURL:URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (error == nil && data != nil) {
                    
                    [self parseWithURL:URL completionBlock:^(SVGAVideoEntity * _Nullable videoItem) {
                        
                        if (completionBlock) {
                            
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                
                                completionBlock(videoItem);
                            }];
                        }
                        
                    } failureBlock:^(NSError * _Nullable error) {
                        
                        if (failureBlock) {
                            
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                
                                failureBlock(error);
                            }];
                        }
                    }];
                    
                    //svga写入文件
                    [data writeToFile:svgaFilePath atomically:YES];
                    
                    //版本写入文件
                    NSString * svga_version = (version && ![version isEqualToString:@""]) ? version : @"0";
                    //检测是否存在Version文件,如果没有创建并写入
                    if (![fileMgr fileExistsAtPath:versionFilePath]) {
                        
                        [fileMgr createFileAtPath:versionFilePath contents:nil attributes:nil];
                    }
                    [svga_version writeToFile:versionFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
                    
                }else {
                    if (failureBlock) {
                        
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            failureBlock(error);
                        }];
                    }
                }
            }] resume];
            
        }
        
        return;
    }
    
    //不存在svga 下载svga动画
    //svga写入文件下载 写入
    [[[NSURLSession sharedSession] dataTaskWithURL:URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil && data != nil) {
            
            [self parseWithURL:URL completionBlock:^(SVGAVideoEntity * _Nullable videoItem) {
               
                if (completionBlock) {
                    
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        
                        completionBlock(videoItem);
                    }];
                }
                
            } failureBlock:^(NSError * _Nullable error) {
                
                if (failureBlock) {
                    
                    failureBlock(error);
                }
            }];
            
            //svga写入文件
            [fileMgr createFileAtPath:svgaFilePath contents:data attributes:nil];
            
            //版本写入文件
            NSString * svga_version = (version && ![version isEqualToString:@""]) ? version : @"0";
            //检测是否存在Version文件,如果没有创建并写入
            if (![fileMgr fileExistsAtPath:versionFilePath]) {
                
                [fileMgr createFileAtPath:versionFilePath contents:nil attributes:nil];
            }
            [svga_version writeToFile:versionFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
            
        }else {
            if (failureBlock) {
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    failureBlock(error);
                }];
            }
        }
    }] resume];
}

+(NSInteger)memoryAllSzie{
    
    return 0;
}

+(void)removeAllMemorySvgas:(void (^)(BOOL))sucBlock{
    
    NSString *memoryDir = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:[NSString stringWithFormat:@"SVGA"]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:memoryDir]) {
        
        BOOL isSuccess = [fileManager removeItemAtPath:memoryDir error:nil];
        sucBlock(isSuccess);
    }else{
        
        sucBlock(YES);
    }
}

#pragma mark - Private
//文件夹SVGA 不存在创建
-(nullable NSString *)memorySVGADir:(NSURL *)url{
    
    NSFileManager * fileMgr = [NSFileManager defaultManager];
    NSString *memoryDir = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:[NSString stringWithFormat:@"SVGA/%@",[self MD5StringExt:url.absoluteString]]];
    
    if (![fileMgr fileExistsAtPath:memoryDir]) { //创建文件夹
        
        [fileMgr createDirectoryAtPath:memoryDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return memoryDir;
}

- (NSString *)MD5StringExt:(NSString *)str {
    const char *cstr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cstr, (CC_LONG)strlen(cstr), result);
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
