//
//  UIView+NMFrameDirection.m
//  NMFrameDemo
//
//  Created by 陈煜钏 on 2018/7/26.
//  Copyright © 2018年 陈煜钏. All rights reserved.
//

#import "UIView+NMFrameDirection.h"

#import "UIView+NMAddition.h"

@implementation UIView (NMFrameDirection)

#pragma mark - getter

- (NMFrameMakerDirection *)nm_left {
    return [NMFrameMakerDirection directionWithView:self type:NMFrameMakerDirectionTypeLeft];
}

- (NMFrameMakerDirection *)nm_right {
    return [NMFrameMakerDirection directionWithView:self type:NMFrameMakerDirectionTypeRight];
}

- (NMFrameMakerDirection *)nm_top {
    return [NMFrameMakerDirection directionWithView:self type:NMFrameMakerDirectionTypeTop];
}

- (NMFrameMakerDirection *)nm_bottom {
    return [NMFrameMakerDirection directionWithView:self type:NMFrameMakerDirectionTypeBottom];
}

#pragma mark - setter

- (void)setNm_left:(NMFrameMakerDirection *)nm_left {
    self.nm_x = nm_left.floatValue;
}

- (void)setNm_right:(NMFrameMakerDirection *)nm_right {
    CGRect frame = self.frame;
    frame.origin.x = nm_right.floatValue - CGRectGetWidth(self.frame);
    self.frame = frame;
}

- (void)setNm_top:(NMFrameMakerDirection *)nm_top {
    self.nm_y = nm_top.floatValue;
}

- (void)setNm_bottom:(NMFrameMakerDirection *)nm_bottom {
    CGRect frame = self.frame;
    frame.origin.x = nm_bottom.floatValue - CGRectGetHeight(self.frame);
    self.frame = frame;
}

@end
