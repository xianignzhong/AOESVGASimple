//
//  AOESVGAQueue.m
//  AOESVGASimple
//
//  Created by 夏宁忠 on 2018/3/9.
//  Copyright © 2018年 夏宁忠. All rights reserved.
//

#import "AOESVGAQueue.h"

#if __has_include(<SVGAPlayer/SVGA.h>)
#import <SVGAPlayer/SVGA.h>
#elif __has_include("SVGAPlayer/SVGA.h")
#import "SVGAPlayer/SVGA.h"
#else
#import "SVGA.h"
#endif

@interface AOESVGAQueue ()<SVGAPlayerDelegate>

@property (nonatomic, strong)NSOperationQueue *queue;

@property (nonatomic, strong) SVGAPlayer *aPlayer;
@property (nonatomic, strong) SVGAParser *parser;

@end

@implementation AOESVGAQueue

-(void)addSVGAInQueue:(AOESVGAEntity *)entity{
    
    __weak typeof(self)weakSelf = self;
    [self.queue addOperationWithBlock:^{
        
        //暂停当前队列操作,SVGAParser 内部也会进入队列异步等，防止当前动画被后续动画覆盖
        [weakSelf.queue setSuspended:YES];
        
        //更新UI 需要执行到主线程
        dispatch_async(dispatch_get_main_queue(), ^{

            [weakSelf playSVGA:entity];
        });
    }];
}

-(void)playSVGA:(AOESVGAEntity *)entity{
    
    self.aPlayer.frame = entity.svga_forSupviewRect;
    [entity.superView addSubview:self.aPlayer];
    
    __weak typeof(self)weakSelf = self;
    [self.parser parseWithURL:[NSURL URLWithString:entity.svga_url] completionBlock:^(SVGAVideoEntity * _Nullable videoItem) {
        
        if (videoItem != nil) {
            
            weakSelf.aPlayer.videoItem = videoItem;
            [weakSelf.aPlayer startAnimation];
        }
        
    } failureBlock:nil];
}


#pragma mark - <SVGAPlayerDelegate>
-(void)svgaPlayerDidFinishedAnimation:(SVGAPlayer *)player{
    
    //开启队列执行下一个动画
    [self.queue setSuspended:NO];
    
    if (self.queue.operations.count==0) {
        
        //从父视图移除SVGAPlayer 防止按钮遮挡
        [self.aPlayer removeFromSuperview];
    }
}

#pragma mark - dealloc
-(void)dealloc{
    
    NSLog(@"AOESVGAQueue dealloc");
}

#pragma mark - setter/getter
-(SVGAPlayer *)aPlayer{
    
    if (!_aPlayer) {
        
        _aPlayer = [[SVGAPlayer alloc]init];
        _aPlayer.delegate = self;
        _aPlayer.loops = 1;
        _aPlayer.clearsAfterStop = YES;
    }
    
    return _aPlayer;
}

-(SVGAParser *)parser{
    
    if (!_parser) {
        
        _parser = [[SVGAParser alloc]init];
    }
    
    return _parser;
}

-(NSOperationQueue *)queue{
    
    if (!_queue) {
        
        _queue = [[NSOperationQueue alloc]init];
        _queue.maxConcurrentOperationCount = 1;
    }
    
    return _queue;
}

@end
