//
//  RXRefresh.h
//  RXRefresh
//
//  Created by srx on 2017/9/7.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//
//所有方法 参考MJRefresh,内部计算参考LeeRefresh

#ifndef RXRefresh_h
#define RXRefresh_h

/// 通用常亮
#import "RXRefreshConst.h"

/// 基类
#import "RXRefreshView.h"

/// footer
#import "RXRefreshFooter.h"

/// 用来控制 footer
#import "UIScrollView+RXRefresh.h"


#endif /* RXRefresh_h */


/*
    最终效果
 
    【京东 秒杀列表刷新 样式】
 
 
    只能 竖屏 滑动，不支持横屏滑动
 */


/*
    准备 思路：
    1、监听 UIScrollView offset
    2、footer.y = UIScrollView.inset.(top + bottom) + UIScrollView.content.height
    3、footer.label 位置
    4、footer 中 backView 是随着 UIScroll底部可以滑动多少，而展示多少
 
 
 
    效果 思路
    1、当 滑动Y+UIScrollView.height > footer.y  显示默认样式
    2、当 滑动Y+UIScrollView.height > footer.y + 显示块 显示
    3、
 
 
 
 
 
 
 */










