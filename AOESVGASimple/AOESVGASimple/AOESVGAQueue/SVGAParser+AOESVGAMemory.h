//
//  SVGAParser+AOESVGAMemory.h
//  AOESVGASimple
//
//  Created by 夏宁忠 on 2018/3/9.
//  Copyright © 2018年 夏宁忠. All rights reserved.
//

#if __has_include(<SVGAPlayer/SVGAParser.h>)
#import <SVGAPlayer/SVGAParser.h>
#elif __has_include("SVGAPlayer/SVGAParser.h")
#import "SVGAPlayer/SVGAParser.h"
#else
#import "SVGAParser.h"
#endif

#define AOESVGAMemoryDir @"SVGA" //设置Document 下SVGA文件存储路径

@interface SVGAParser (AOESVGAMemory)

/**
 通过url加载svga动画,设置svga文件存储

 @param URL url
 @param completionBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)parseMemoryWithURL:(nonnull NSURL *)URL
                   Version:(NSString *_Nullable)version
           completionBlock:(void ( ^ _Nonnull )(SVGAVideoEntity * _Nullable videoItem))completionBlock
              failureBlock:(void ( ^ _Nullable)(NSError * _Nullable error))failureBlock;

/**
 本地存储大小

 @param sucBlock size k
 */
+ (void)memoryAllSzie:(void (^ _Nullable)(NSUInteger size))sucBlock;

/**
 移除所有本地的SVGA相关文件
 */
+ (void)removeAllMemorySvgas:(void ( ^ _Nullable)(BOOL suc))sucBlock;

@end
