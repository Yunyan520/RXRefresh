//
//  RXRefreshFooter.h
//  RXRefresh
//
//  Created by srx on 2017/9/7.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

#import "RXRefreshView.h"

@interface RXRefreshFooter : RXRefreshView
@property (nonatomic, copy) NSString * nextRefreshText;
@property (nonatomic, assign) CGFloat fontSize;



/** 创建footer */
+ (instancetype)footerWithRefreshingBlock:(RXRefreshCompletionBlock)refreshingBlock;

/** 创建footer */
+ (instancetype)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

@end
