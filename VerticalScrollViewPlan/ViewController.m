//
//  ViewController.m
//  VerticalScrollViewPlan
//
//  Created by 牛新怀 on 2017/8/10.
//  Copyright © 2017年 牛新怀. All rights reserved.
//

#import "ViewController.h"
#import "XHVerticalScrollview.h"
@interface ViewController ()<XHVerticalDelegate>
@property (strong, nonatomic) NSArray * titleArray;
@property (strong, nonatomic) XHVerticalScrollview * customView;
@end
static CGFloat viewHeight = 40;
static CGFloat viewWidth  = 200;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initWithView];
}
- (void)initWithView{
    [self.view addSubview:self.customView];

}
//- (void)viewWillDisappear:(BOOL)animated{
//    [self.customView.myTimer invalidate];
//    self.customView.myTimer = nil;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (XHVerticalScrollview *)customView{
    if (!_customView) {
        _customView = [[XHVerticalScrollview alloc]init];
        _customView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
        _customView.bounds = CGRectMake(0, 0, viewWidth, viewHeight);
        _customView.backgroundColor = [UIColor cyanColor];
        _customView.customArray = self.titleArray;
        _customView.delegate = self;
    }
    
    return _customView;
}

- (NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"今天是一个好天气",@"温度达到了30度以上",@"可是我并没有感觉很热",@"因为什么呢",@"公司开空调了",@"这个是不是可以有啊"];
        // 偶数加2.
    }
    
    return _titleArray;
}
#pragma mark - Delegate
- (void)didSelectTag:(NSInteger)tag withView:(XHVerticalScrollview *)view{
    NSLog(@"用户当前选中的数据是第%ld条",tag);
}
@end
