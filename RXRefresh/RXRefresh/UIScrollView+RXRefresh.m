//
//  UIScrollView+RXRefresh.m
//  RXRefresh
//
//  Created by srx on 2017/9/7.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

#import "UIScrollView+RXRefresh.h"
#import "RXRefreshFooter.h"
#import <objc/runtime.h>

@implementation UIScrollView (RXRefresh)

static const char RXRefreshFooterKey = '\0';
- (void)setFooter:(RXRefreshFooter *)footer {
    if (footer != self.footer) {
        // 删除旧的，添加新的
        [self.footer removeFromSuperview];
        [self insertSubview:footer atIndex:0];
        
        // 存储新的
        [self willChangeValueForKey:@"footer"]; // KVO
        objc_setAssociatedObject(self, &RXRefreshFooterKey,
                                 footer, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"footer"]; // KVO
    }
}

- (RXRefreshFooter *)footer {
    return  objc_getAssociatedObject(self, &RXRefreshFooterKey);
}


@end
