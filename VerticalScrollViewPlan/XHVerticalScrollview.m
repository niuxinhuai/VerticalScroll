//
//  XHVerticalScrollview.m
//  VerticalScrollViewPlan
//
//  Created by 牛新怀 on 2017/8/10.
//  Copyright © 2017年 牛新怀. All rights reserved.
//

#import "XHVerticalScrollview.h"
@interface XHVerticalScrollview()<UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView * verticalScroll;
@property (strong, nonatomic) NSMutableArray * mutableArray;
@end
static NSInteger Gap = 10;
@implementation XHVerticalScrollview


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [self addSubview:self.verticalScroll];
    [self setUpTimer];
  
}
- (void)setUpTimer{
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(changeScrollContentOffSetY) userInfo:nil repeats:YES];
    _myTimer = timer;
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
- (void)invalidateTimer{
    [_myTimer invalidate];
    _myTimer = nil;
}
/*
 @parameter setter

 */

- (void)setCustomArray:(NSArray *)customArray{
    _customArray = customArray;
    if (!_customArray)return;
    self.mutableArray = [NSMutableArray arrayWithArray:_customArray];
    [self initWithDataSourse];
    
}
- (UIScrollView *)verticalScroll{
    if (!_verticalScroll) {
        _verticalScroll = [[UIScrollView alloc]initWithFrame:self.bounds];
        _verticalScroll.showsVerticalScrollIndicator = NO;
        _verticalScroll.scrollEnabled = NO;
        _verticalScroll.bounces = NO;
        _verticalScroll.delegate = self;
        
    }
    return _verticalScroll;
}
- (void)initWithDataSourse{
    if (_customArray.count%2 ==0) {
        NSLog(@"偶数");
    }else{
        NSLog(@"基数");
        for (int i=0; i<_customArray.count; i++) {
            [self.mutableArray addObject:_customArray[i]];
        }
    
    }
    [self.mutableArray addObject:_customArray[0]];
    [self.mutableArray addObject:_customArray[1]];
    NSLog(@"%@",self.mutableArray);
    int m;
    int n;
    for (int i =0; i<self.mutableArray.count/2; i++) {
        UIView * view = [[UIView alloc]init];
        view.backgroundColor = [UIColor redColor];
        view.frame = CGRectMake(0, i*self.verticalScroll.frame.size.height, self.verticalScroll.frame.size.width, self.verticalScroll.frame.size.height);
        view.tag = i + Gap;
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gestureClick:)];
        [view addGestureRecognizer:tap];
        [self.verticalScroll addSubview:view];


        m = i*2;
        n = i*2+1;
        UILabel * label = [[UILabel alloc]init];
        label.frame = CGRectMake(0, 0, self.verticalScroll.frame.size.width, view.frame.size.height/2);
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [NSString stringWithFormat:@"%d%@",i,self.mutableArray[m]];
        label.tag = i + Gap;
        label.textColor = [UIColor blackColor];
        label.userInteractionEnabled = YES;

        [view addSubview:label];
        UILabel * label1 = [[UILabel alloc]init];
        label1.frame = CGRectMake(0, view.frame.size.height/2, self.verticalScroll.frame.size.width, view.frame.size.height/2);
        label1.textAlignment = NSTextAlignmentCenter;
        label1.text = [NSString stringWithFormat:@"%d%@",i,self.mutableArray[n]];
        label1.tag = i + Gap;
        label1.textColor = [UIColor blackColor];
        label1.userInteractionEnabled = YES;
        [view addSubview:label1];
        
       
    }
    self.verticalScroll.contentSize = CGSizeMake(0, (self.mutableArray.count/2)*self.verticalScroll.frame.size.height);

}

// 点击滚动条数据
- (void)gestureClick:(UITapGestureRecognizer *)gesture{
    if ([self.delegate respondsToSelector:@selector(didSelectTag:withView:)]) {
        [self.delegate didSelectTag:gesture.view.tag-Gap withView:self];
    }
}
-(void)changeScrollContentOffSetY{
    //启动定时器
    CGPoint point = self.verticalScroll.contentOffset;
    [self.verticalScroll setContentOffset:CGPointMake(0, point.y+CGRectGetHeight(self.verticalScroll.frame)) animated:YES];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{

   // NSLog(@"endani");
    if (scrollView.contentOffset.y==scrollView.contentSize.height-CGRectGetHeight(self.verticalScroll.frame)){
        [scrollView setContentOffset:CGPointMake(0,0)];
    }
    

}
- (NSMutableArray *)mutableArray{
    if (!_mutableArray) {
        _mutableArray = [[NSMutableArray alloc]init];
    }
    return _mutableArray;
}
- (void)dealloc{
    [self invalidateTimer];
}
@end
