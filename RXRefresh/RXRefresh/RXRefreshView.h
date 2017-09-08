//
//  RXRefreshView.h
//  RXRefresh
//
//  Created by srx on 2017/9/7.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RXRefreshConst.h"
#import "UIView+RXRefresh.h"

typedef NS_ENUM(NSInteger, RXRefreshViewState) {
    RXRefreshViewStateWillRefresh,
    RXRefreshViewStateRefreshing,
    RXRefreshViewStateNormal,
    RXRefreshViewStateNoMoreData //没有数据
};

typedef void(^RXRefreshCompletionBlock)();

@interface RXRefreshView : UIView

@property (nonatomic, weak) UIScrollView * scrollView;

/** 记录原始contentEdgeInsets */
@property (nonatomic, assign) UIEdgeInsets originalEdgeInsets;
// 子类自定义位置使用
@property (nonatomic, assign) UIEdgeInsets scrollViewEdgeInsets;

/** 刷新的回调 */
@property (nonatomic, copy) RXRefreshCompletionBlock refreshCompletionBlock;
/** 回调对象 */
@property (nonatomic, weak) id refreshTarget;
/** 回调方法 */
@property (nonatomic, assign) SEL refreshAction;
/** 进入刷新状态 */
- (void)beginRefreshing;

/** 结束刷新状态 */
- (void)endRefreshing;

/** 刷新状态 一般交给子类内部实现 */
@property (assign, nonatomic) RXRefreshViewState refreshState;


@end
