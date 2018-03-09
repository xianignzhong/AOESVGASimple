//
//  ViewController.m
//  AOESVGASimple
//
//  Created by 夏宁忠 on 2018/3/9.
//  Copyright © 2018年 夏宁忠. All rights reserved.
//

#import "ViewController.h"
#import "AOESVGAQueue.h"

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
                       @"title":@"爱心天使"
                       },
                   @{
                       @"url":@"https://github.com/yyued/SVGA-Samples/blob/master/halloween.svga?raw=true",
                       @"title":@"黑暗魔法师"
                       },
                   @{
                       @"url":@"https://github.com/yyued/SVGA-Samples/blob/master/kingset.svga?raw=true",
                       @"title":@"皇冠头像"
                       },
                   @{
                       @"url":@"https://github.com/yyued/SVGA-Samples/blob/master/posche.svga?raw=true",
                       @"title":@"跑车"
                       },
                   @{
                       @"url":@"https://github.com/yyued/SVGA-Samples/blob/master/rose.svga?raw=true",
                       @"title":@"梅花开"
                       },
                   @{
                       @"url":@"https://github.com/yyued/SVGA-Samples/blob/master/EmptyState.svga?raw=true",
                       @"title":@"西瓜"
                       },
                   @{
                       @"url":@"https://github.com/yyued/SVGA-Samples/blob/master/HamburgerArrow.svga?raw=true",
                       @"title":@"箭头按钮"
                       },
                   @{
                       @"url":@"https://github.com/yyued/SVGA-Samples/blob/master/PinJump.svga?raw=true",
                       @"title":@"跳跳Location"
                       },
                   @{
                       @"url":@"https://github.com/yyued/SVGA-Samples/blob/master/TwitterHeart.svga?raw=true",
                       @"title":@"爱心点赞"
                       },
                   @{
                       @"url":@"https://github.com/yyued/SVGA-Samples/blob/master/Walkthrough.svga?raw=true",
                       @"title":@"变幻家庭装"
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
    entity.svga_url = self.items[self.i][@"url"];
    entity.svga_title = self.items[self.i][@"title"];
    entity.superView = self.animationView;
    entity.svga_forSupviewRect = CGRectMake(0, 0, 240, 350);
    
    [self.svgaQueue addSVGAInQueue:entity];
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
    }
    
    return _svgaQueue;
}

@end