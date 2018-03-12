//
//  AOESVGAQueue.h
//  AOESVGASimple
//
//  Created by 夏宁忠 on 2018/3/9.
//  Copyright © 2018年 夏宁忠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AOESVGAEntity.h"

@interface AOESVGAQueue : NSObject

/**
 是否开启本地存储
 */
@property (nonatomic, assign)BOOL isMemory;

/**
 添加动画进队列

 @param entity 动画信息对象
 */
-(void)addSVGAInQueue:(AOESVGAEntity *)entity;

@end
