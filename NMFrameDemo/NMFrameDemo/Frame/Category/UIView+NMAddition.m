//
//  UIView+NMAddition.m
//  nimo
//
//  Created by 陈煜钏 on 2018/3/14.
//  Copyright © 2018年 HUYA. All rights reserved.
//

#import "UIView+NMAddition.h"

@implementation UIView (NMAddition)

- (CGFloat)nm_width {
    return self.frame.size.width;
}

- (CGFloat)nm_height {
    return self.frame.size.height;
}

- (CGFloat)nm_x {
    return self.frame.origin.x;
}

- (CGFloat)nm_y {
    return self.frame.origin.y;
}

- (NSNumber *)nm_centerX {
    return @(self.center.x);
}

- (NSNumber *)nm_centerY {
    return @(self.center.y);
}

- (void)setNm_width:(CGFloat)nm_width {
    CGRect frame = self.frame;
    frame.size.width = nm_width;
    self.frame = frame;
}

- (void)setNm_height:(CGFloat)nm_height {
    CGRect frame = self.frame;
    frame.size.height = nm_height;
    self.frame = frame;
}
- (void)setNm_x:(CGFloat)nm_x {
    CGRect frame = self.frame;
    frame.origin.x = nm_x;
    self.frame = frame;
}

- (void)setNm_y:(CGFloat)nm_y {
    CGRect frame = self.frame;
    frame.origin.y = nm_y;
    self.frame = frame;
}

- (void)setNm_centerX:(NSNumber *)nm_centerX {
    CGPoint center = self.center;
    center.x = nm_centerX.floatValue;
    self.center = center;
}

- (void)setNm_centerY:(NSNumber *)nm_centerY {
    CGPoint center = self.center;
    center.y = nm_centerY.floatValue;
    self.center = center;
}

@end
