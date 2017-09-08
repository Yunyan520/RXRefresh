//
//  RXRefreshConst.h
//  RXRefresh
//
//  Created by srx on 2017/9/7.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/message.h>


// 运行时objc_msgSend
#define RXRefreshMsgSend(...) ((void (*)(void *, SEL, UIView *))objc_msgSend)(__VA_ARGS__)
#define RXRefreshMsgTarget(target) (__bridge void *)(target)


// 常量
/// 刷新view高度
UIKIT_EXTERN const CGFloat RXRefreshViewDefaultHeight;
/// 底部文字大小
UIKIT_EXTERN  const CGFloat RXRefreshLabelFontSize;

/// 监听UIScroll.offset
UIKIT_EXTERN NSString *const RXRefreshKeyPathContentOffset;

UIKIT_EXTERN NSString *const RXRefreshLabelWillRefreshTxt;
UIKIT_EXTERN NSString *const RXRefreshLabelWillRefreshTxt;



