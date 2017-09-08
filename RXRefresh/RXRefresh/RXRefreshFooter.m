//
//  RXRefreshFooter.m
//  RXRefresh
//
//  Created by srx on 2017/9/7.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

#import "RXRefreshFooter.h"

@interface RXRefreshFooter()
{
    UIView * _backView;
    UILabel * _txtLabel;
    
    CGFloat _originalScrollViewContentHeight;
}
@end

@implementation RXRefreshFooter

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        _backView = [[UIView alloc] initWithFrame:self.bounds];
        _backView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_backView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _originalScrollViewContentHeight = self.scrollView.contentSize.height;
    self.center = CGPointMake(self.scrollView.width * 0.5, self.scrollView.contentSize.height + self.height * 0.5); // + self.scrollView.contentInset.bottom
    _backView.y = 0;
//    self.footerView.center  = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0 );
//    self.hidden = [self shouldHide];
}

- (BOOL)shouldHide{
    return (self.scrollView.bounds.size.height > self.y);
}

- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    self.scrollViewEdgeInsets = UIEdgeInsetsMake(0, 0, self.height, 0);
}


// 交给子类处理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (![keyPath isEqualToString:RXRefreshKeyPathContentOffset] || self.refreshState == RXRefreshViewStateRefreshing) return;
    CGFloat y = [change[@"new"] CGPointValue].y;
    NSLog(@"y=%.2f content.height=%.2f,self.height=%.2f", y, self.scrollView.contentSize.height, self.height);
    _backView.height = y;
    _backView.width = self.scrollView.width;
    //NSLog(@"\n\n\nself.frame=%@\n_backView.frame=%@\n\n\n\n", NSStringFromCGRect(self.frame), NSStringFromCGRect(_backView.frame));
    CGFloat criticalY = self.scrollView.contentSize.height - self.scrollView.height + self.height + self.scrollView.contentInset.bottom + self.scrollView.contentInset.top;
    
    
    if ((y <= 0) || (self.scrollView.bounds.size.height == 0)) return;
    
    CGFloat valueY = y + self.scrollView.height + self.scrollView.contentInset.top + self.scrollView.contentInset.bottom;
    
    if(valueY > self.y + RXRefreshViewDefaultHeight) {
        //加载 动画
        NSLog(@"加载动画");
    }
    else if(valueY > self.y ) {
        //将要 加载动画
        NSLog(@"将要 加载动画");
    }
    else {
        NSLog(@"不变");
    }
    
    
    return;
    //NSLog(@"criticalY=%.2f", criticalY);
//    CGFloat criticalY = self.scrollView.height + y;
    // 如果scrollView内容有增减，重新调整refreshFooter位置
    if (self.scrollView.contentSize.height != _originalScrollViewContentHeight) {
        //NSLog(@"00000 layoutSubviews");
        [self layoutSubviews];
    }
    // 只有在 y>0 以及 scrollview的高度不为0 时才判断
    if ((y <= 0) || (self.scrollView.bounds.size.height == 0)) return;
    // 触发RXRefreshViewStateRefreshing状态
    if (y <= criticalY && (self.refreshState == RXRefreshViewStateWillRefresh) && !self.scrollView.isDragging) {
        //NSLog(@"00000 写动画");
        //如果有动画，写动画
        
        [self setRefreshState:RXRefreshViewStateRefreshing];
        return;
    }
    // 触发RXRefreshViewStateWillRefresh状态
    if (y > criticalY && (self.refreshState == RXRefreshViewStateNormal)) {
        //如果上拉加载隐藏了 在往上拉就切换状态了
        //NSLog(@"00000 是否隐藏");
        if (self.hidden) return;
        //NSLog(@"00000 没有隐藏 改为拉伸状态");
        [self setRefreshState:RXRefreshViewStateWillRefresh];
        return;
    }
    //触发RXRefreshViewStateNormal状态
    if (y <= criticalY && self.scrollView.isDragging && (RXRefreshViewStateNormal != self.refreshState)) {
        //NSLog(@"00000 歇菜了");
        [self setRefreshState:RXRefreshViewStateNormal];
    }
}

- (void)beginRefreshing {
    [super beginRefreshing];
}

/** 结束刷新状态 */
- (void)endRefreshing {
    [super endRefreshing];
}



/** 创建footer */
+ (instancetype)footerWithRefreshingBlock:(RXRefreshCompletionBlock)refreshingBlock {
    RXRefreshFooter * footer = [[RXRefreshFooter alloc] init];
    footer.refreshCompletionBlock = refreshingBlock;
    return footer;
}

/** 创建footer */
+ (instancetype)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action {
    RXRefreshFooter * footer = [[RXRefreshFooter alloc] init];
    footer.refreshTarget = target;
    footer.refreshAction = action;
    return footer;
}

@end
