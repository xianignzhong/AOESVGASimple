//
//  AOESVGAEntity.h
//  AOESVGASimple
//
//  Created by 夏宁忠 on 2018/3/9.
//  Copyright © 2018年 夏宁忠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AOESVGAEntity : NSObject

/**
 svga文件版本:如果存在本地存储，可能出现URL相同但服务端文件已经更新
 */
@property (nonatomic, strong)NSString *svga_version;

/**
 SVGA URL 网络/本地
 */
@property (nonatomic, strong)NSString *svga_url;

/**
 SVGA 标题
 */
@property (nonatomic, strong)NSString *svga_title;

/**
 SVGA 描述
 */
@property (nonatomic, strong)NSString *svga_description;

/**
 SVGA 基于父视图的位置
 */
@property (nonatomic, assign)CGRect svga_forSupviewRect;

/**
 SVGA 显示的父视图
 */
@property (nonatomic, strong)id superView;


@end
