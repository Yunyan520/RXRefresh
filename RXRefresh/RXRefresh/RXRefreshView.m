//
//  RXRefreshView.m
//  RXRefresh
//
//  Created by srx on 2017/9/7.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

#import "RXRefreshView.h"


@interface RXRefreshView()
{
    
    BOOL _hasSetOriginalInsets;
}
@end

@implementation RXRefreshView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}


/**
 视图出现方法
 
 @param newSuperview scrollivew
 */
- (void)willMoveToSuperview:(UIView *)newSuperview{
    
    [super willMoveToSuperview:newSuperview];
    if (!newSuperview) {
        [self.superview removeObserver:self forKeyPath:RXRefreshKeyPathContentOffset];
    }else{
        self.scrollView = (UIScrollView *)newSuperview;
        [self.scrollView addObserver:self forKeyPath:RXRefreshKeyPathContentOffset options:NSKeyValueObservingOptionNew context:nil];
    }
    
}
- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    self.bounds = CGRectMake(0, 0, self.scrollView.frame.size.width, RXRefreshViewDefaultHeight);
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
}



// 获得在scrollView的contentInset原来基础上增加一定值之后的新contentInset
- (UIEdgeInsets)syntheticalEdgeInsetsWithEdgeInsets:(UIEdgeInsets)edgeInsets{
    
    return UIEdgeInsetsMake(_originalEdgeInsets.top + edgeInsets.top, _originalEdgeInsets.left + edgeInsets.left, _originalEdgeInsets.bottom + edgeInsets.bottom, _originalEdgeInsets.right + edgeInsets.right);
}

- (void)endRefreshingWithCompletionBlock:(void (^)())completionBlock {
    _refreshCompletionBlock = completionBlock;
}

// 根据状态进行刷新操作
- (void)setRefreshState:(RXRefreshViewState)refreshState{
    
    _refreshState = refreshState;
    switch (refreshState) {
        case RXRefreshViewStateRefreshing:{
            if (!_hasSetOriginalInsets) {
                _originalEdgeInsets = self.scrollView.contentInset;
                _hasSetOriginalInsets = YES;
            }
            _scrollView.contentInset = [self syntheticalEdgeInsetsWithEdgeInsets:self.scrollViewEdgeInsets];
            //1、方法
            RXRefreshMsgSend(RXRefreshMsgTarget(self.refreshTarget), self.refreshAction, self);
            
            //2、block回调
            if(_refreshCompletionBlock){
                _refreshCompletionBlock();
            }
        }
            break;
            
        case RXRefreshViewStateWillRefresh:{
            
            NSLog(@"将要刷新......");
            
        }
            break;
            
        case RXRefreshViewStateNormal:{
            
            NSLog(@"重置刷新......");
        }
            break;
        case RXRefreshViewStateNoMoreData: {
            NSLog(@"没有数据了 或者为下一个、或者没有......");
        }
            break;
        default:
            break;
    }
}


/** 进入刷新状态 */
- (void)beginRefreshing {
    [self setRefreshState:RXRefreshViewStateWillRefresh];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self executeRefreshingCallback];
    });
    
}
- (void)executeRefreshingCallback
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.refreshCompletionBlock) {
            self.refreshCompletionBlock();
        }
        if ([self.refreshTarget respondsToSelector:self.refreshAction]) {
            RXRefreshMsgSend(RXRefreshMsgTarget(self.refreshTarget), self.refreshAction, self);
        }
    });
}

- (void)endRefreshing {
    
    [UIView animateWithDuration:0.2 animations:^{
        _scrollView.contentInset = _originalEdgeInsets;
        
    } completion:^(BOOL finished) {
        [self setRefreshState:RXRefreshViewStateNormal];
        //手动刷新
//        if (self.isManuallyRefreshing) {
//            self.isManuallyRefreshing = NO;
//        }
    }];
    
}

// 交给子类处理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
}

-(void)setIsManuallyRefreshing:(BOOL)isManuallyRefreshing{
    
//    _isManuallyRefreshing = isManuallyRefreshing;
//    if (_isManuallyRefreshing) {
//        [self setNeedsLayout];
//        [self layoutIfNeeded];
//    }
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
