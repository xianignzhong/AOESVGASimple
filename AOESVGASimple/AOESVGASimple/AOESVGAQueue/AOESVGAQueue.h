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

@property (nonatomic, assign)BOOL isMemory;

-(void)addSVGAInQueue:(AOESVGAEntity *)entity;

@end
