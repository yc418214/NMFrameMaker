//
//  NMFrameMakerDirection.m
//  NMFrameDemo
//
//  Created by 陈煜钏 on 2018/7/26.
//  Copyright © 2018年 陈煜钏. All rights reserved.
//

#import "NMFrameMakerDirection.h"

@interface NMFrameMakerDirection ()

@property (nonatomic, readwrite, weak) UIView *view;

@property (nonatomic, assign) NMFrameMakerDirectionType type;

@end

@implementation NMFrameMakerDirection

+ (instancetype)directionWithView:(UIView *)view type:(NMFrameMakerDirectionType)type {
    NMFrameMakerDirection *direction = [[NMFrameMakerDirection alloc] init];
    direction.view = view;
    direction.type = type;
    return direction;
}

#pragma mark - getter

- (CGFloat)floatValue {
    CGFloat floatValue = 0.f;
    switch (self.type) {
        case NMFrameMakerDirectionTypeLeft: {
            floatValue = CGRectGetMinX(self.view.frame);
            break;
        }
        case NMFrameMakerDirectionTypeRight: {
            floatValue = CGRectGetMaxX(self.view.frame);
            break;
        }
        case NMFrameMakerDirectionTypeTop: {
            floatValue = CGRectGetMinY(self.view.frame);
            break;
        }
        case NMFrameMakerDirectionTypeBottom: {
            floatValue = CGRectGetMaxY(self.view.frame);
            break;
        }
    }
    return floatValue;
}

@end
