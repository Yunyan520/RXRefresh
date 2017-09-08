//
//  UIView+RXRefresh.h
//  RXRefresh
//
//  Created by srx on 2017/9/7.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RXRefresh)
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat centerY;

- (CGSize)getTheNewSizeWith:(NSString*)text andFont:(UIFont*)font;
@end
