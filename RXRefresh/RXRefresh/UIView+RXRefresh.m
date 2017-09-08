//
//  UIView+RXRefresh.m
//  RXRefresh
//
//  Created by srx on 2017/9/7.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

#import "UIView+RXRefresh.h"

@implementation UIView (RXRefresh)

- (CGFloat)height {
    return self.frame.size.height;
}
- (void)setHeight:(CGFloat)height {
    CGRect temp = self.frame;
    temp.size.height = height;
    self.frame = temp;
}


- (CGFloat)width {
    return self.frame.size.width;
}
- (void)setWidth:(CGFloat)width {
    CGRect temp = self.frame;
    temp.size.width = width;
    self.frame = temp;
}


- (CGFloat)x {
    return self.frame.origin.x;
}
- (void)setX:(CGFloat)x {
    CGRect temp = self.frame;
    temp.origin.x = x;
    self.frame = temp;
}



- (CGFloat)y {
    return self.frame.origin.y;
}
- (void)setY:(CGFloat)y {
    CGRect temp = self.frame;
    temp.origin.y = y;
    self.frame = temp;
}


-(CGFloat)centerY {
    return self.center.y;
}
-(void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
    
}


- (CGSize)getTheNewSizeWith:(NSString *)text andFont:(UIFont *)font{
    
    NSDictionary *attributes = @{NSFontAttributeName:font};
    
    CGSize textSize = [text sizeWithAttributes:attributes];
    
    return textSize;
}

@end
