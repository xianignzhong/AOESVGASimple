//
//  ViewController.m
//  AOESVGASimple
//
//  Created by 夏宁忠 on 2018/3/9.
//  Copyright © 2018年 夏宁忠. All rights reserved.
//

#import "ViewController.h"
#import "AOESVGAQueue.h"

#import "SVGAParser+AOESVGAMemory.h"

@interface ViewController ()

@property (nonatomic, strong)AOESVGAQueue *svgaQueue;

@property (weak, nonatomic) IBOutlet UIView *animationView;

@property (nonatomic, strong)NSArray *items;
@property (nonatomic, assign)NSInteger i;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.items = @[@{
                       @"url":@"https://github.com/yyued/SVGA-Samples/blob/master/angel.svga?raw=true",
                       @"title":@"爱心天使",
                       @"version":@"2.0"
                       },
                   @{
                       @"url":@"https://github.com/yyued/SVGA-Samples/blob/master/halloween.svga?raw=true",
                       @"title":@"黑暗魔法师",
                       @"version":@"1.0"
                       },
                   @{
                       @"url":@"https://github.com/yyued/SVGA-Samples/blob/master/kingset.svga?raw=true",
                       @"title":@"皇冠头像",
                       @"version":@"1.0"
                       },
                   @{
                       @"url":@"https://github.com/yyued/SVGA-Samples/blob/master/posche.svga?raw=true",
                       @"title":@"跑车",
                       @"version":@"1.0"
                       },
                   @{
                       @"url":@"https://github.com/yyued/SVGA-Samples/blob/master/rose.svga?raw=true",
                       @"title":@"梅花开",
                       @"version":@"1.0"
                       },
                   @{
                       @"url":@"https://github.com/yyued/SVGA-Samples/blob/master/EmptyState.svga?raw=true",
                       @"title":@"西瓜",
                       @"version":@"1.0"
                       },
                   @{
                       @"url":@"https://github.com/yyued/SVGA-Samples/blob/master/HamburgerArrow.svga?raw=true",
                       @"title":@"箭头按钮",
                       @"version":@"1.0"
                       },
                   @{
                       @"url":@"https://github.com/yyued/SVGA-Samples/blob/master/PinJump.svga?raw=true",
                       @"title":@"跳跳Location",
                       @"version":@"1.0"
                       },
                   @{
                       @"url":@"https://github.com/yyued/SVGA-Samples/blob/master/TwitterHeart.svga?raw=true",
                       @"title":@"爱心点赞",
                       @"version":@"1.0"
                       },
                   @{
                       @"url":@"https://github.com/yyued/SVGA-Samples/blob/master/Walkthrough.svga?raw=true",
                       @"title":@"变幻家庭装",
                       @"version":@"1.0"
                       }
                   ];
    self.i = -1;
    
}

- (IBAction)add:(id)sender {
    
    self.i = self.i + 1;
    
    if (self.i==10) {
        
        self.i = 0;
    }
    
    AOESVGAEntity * entity = [[AOESVGAEntity alloc]init];
    entity.svga_version = self.items[self.i][@"version"];
    entity.svga_url = self.items[self.i][@"url"];
    entity.svga_title = self.items[self.i][@"title"];
    entity.superView = self.animationView;
    entity.svga_forSupviewRect = CGRectMake(0, 0, 240, 350);
    
    [self.svgaQueue addSVGAInQueue:entity];
}

- (IBAction)clear:(id)sender {
    
    [SVGAParser removeAllMemorySvgas:^(BOOL suc) {
        
        if (suc) {
            
            //清理完成
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"标题" message:@"SVGA文件清理完成" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
}

- (IBAction)calculation:(id)sender {
    
    [SVGAParser memoryAllSzie:^(NSUInteger size) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"标题" message:[NSString stringWithFormat:@"%ldK",(long)size] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    
    NSLog(@"ViewController dealloc");
}

#pragma mark -
-(AOESVGAQueue *)svgaQueue{
    
    if (!_svgaQueue) {
        
        _svgaQueue = [[AOESVGAQueue alloc]init];
        _svgaQueue.isMemory = YES;
    }
    
    return _svgaQueue;
}

@end
