//
//  NMFrameMaker.m
//  nimo
//
//  Created by 陈煜钏 on 2018/4/4.
//  Copyright © 2018年 HUYA. All rights reserved.
//

#import "NMFrameMaker.h"

#import <objc/runtime.h>

typedef NS_OPTIONS(NSInteger, NMLessThanOrEqualToFrameType) {
    NMLessThanOrEqualToFrameTypeNone  = 0,
    NMLessThanOrEqualToFrameTypeRight = 1 << 0,
    NMLessThanOrEqualToFrameTypeWidth = 1 << 1
};

typedef NS_OPTIONS(NSInteger, NMGreaterThanOrEqualToFrameType) {
    NMGreaterThanOrEqualToFrameTypeNone     = 0,
    NMGreaterThanOrEqualToFrameTypeWidth    = 1 << 0,
    NMGreaterThanOrEqualToFrameTypeHeight   = 1 << 1
};

static char *kObserveCustomUpdateFrameKey;

@interface NMFrameMaker ()

@property (nonatomic, weak) UIView *view;

@property (nonatomic, assign) CGFloat originalWidth;

@property (nonatomic, assign) CGFloat originalHeight;

@property (nonatomic, readwrite, strong) NSMutableDictionary<NSNumber *, NMFrameMakerType *> *typesDictionary;

@end

@implementation NMFrameMaker

+ (instancetype)makerWithView:(UIView *)view {
    NMFrameMaker *frameMaker = [[NMFrameMaker alloc] init];
    frameMaker.view = view;
    
#warning 这里考虑把sizeToFit放在每次commit，还是看具体情况手动调用
    @weakify(frameMaker, view);
    [[view rac_signalForSelector:@selector(sizeToFit)] subscribeNext:^(RACTuple *x) {
        @strongify(frameMaker, view);
        frameMaker.originalWidth = view.nm_width;
        frameMaker.originalHeight = view.nm_height;
    }];
    [view sizeToFit];
    
    [frameMaker observeCustomUpdateFrameSignal];
    
    return frameMaker;
}

#pragma mark - public methods

- (void)commit {
    CGRect previousBounds = self.view.bounds;
    CGRect previousRect = self.view.frame;
    
    CGFloat left = CGFLOAT_MAX;
    CGFloat right = CGFLOAT_MAX;
    CGFloat top = CGFLOAT_MAX;
    CGFloat bottom = CGFLOAT_MAX;
    CGFloat centerX = CGFLOAT_MAX;
    CGFloat centerY = CGFLOAT_MAX;
    CGFloat width = CGFLOAT_MAX;
    CGFloat height = CGFLOAT_MAX;
    
    NMLessThanOrEqualToFrameType lessThanOrEqualToFrameType = NMLessThanOrEqualToFrameTypeNone;
    NMGreaterThanOrEqualToFrameType greaterThanOrEqualToFrameType = NMGreaterThanOrEqualToFrameTypeNone;
    
    for (NMFrameMakerType *type in self.typesDictionary.allValues) {
        UIView *anotherView = type.anotherView;
        NSNumber *number = type.number;
        NSValue *value = type.value;
        NMFrameMakerDirection *direction = type.direction;
        
        //保存相关的view
        if (anotherView) {
            [self addAndObserveRelativeView:anotherView];
        } else if (direction.view) {
            [self addAndObserveRelativeView:direction.view];
        }
        
#define IS_SUPERVIEW                   (self.view.superview == anotherView)
#define IS_THE_SAME_SUPERVIEW          (self.view.superview == anotherView.superview)
        
        CGFloat offset = type.makerOperation.nm_offset;
        CGFloat multipliedBy = type.makerOperation.nm_multipliedBy;
        switch (type.currentType) {
            case NMFrameTypeNone : {
                break;
            }
            case NMFrameTypeLeft : {
                if (anotherView) {
                    if (IS_SUPERVIEW) {
                        left = 0;
                    } else if (IS_THE_SAME_SUPERVIEW) {
                        left = anotherView.nm_x;
                    }
                } else if (number) {
                    left = number.floatValue;
                } else if (direction) {
                    left = direction.floatValue;
                }
                left += offset;
                break;
            }
            case NMFrameTypeRight : {
                if (anotherView) {
                    if (IS_SUPERVIEW) {
                        right = anotherView.nm_width;
                    } else if (IS_THE_SAME_SUPERVIEW) {
                        right = CGRectGetMaxX(anotherView.frame);
                    }
                } else if (number) {
                    right = number.floatValue;
                } else if (direction) {
                    right = direction.floatValue;
                }
                right -= offset;
                if (type.usingLessThanOrEqualTo) {
                    lessThanOrEqualToFrameType |= NMLessThanOrEqualToFrameTypeRight;
                }
                break;
            }
            case NMFrameTypeTop : {
                if (anotherView) {
                    if (IS_SUPERVIEW) {
                        top = 0;
                    } else if (IS_THE_SAME_SUPERVIEW) {
                        top = anotherView.nm_y;
                    }
                } else if (number) {
                    top = number.floatValue;
                } else if (direction) {
                    top = direction.floatValue;
                }
                top += offset;
                break;
            }
            case NMFrameTypeBottom : {
                if (anotherView) {
                    if (IS_SUPERVIEW) {
                        bottom = anotherView.nm_height;
                    } else if (IS_THE_SAME_SUPERVIEW) {
                        bottom = CGRectGetMaxY(anotherView.frame);
                    }
                } else if (number) {
                    bottom = number.floatValue;
                } else if (direction) {
                    bottom = direction.floatValue;
                }
                bottom -= offset;
                break;
            }
            case NMFrameTypeCenter : {
                if (anotherView) {
                    if (IS_SUPERVIEW) {
                        centerX = anotherView.nm_width / 2;
                        centerY = anotherView.nm_height / 2;
                    } else if (IS_THE_SAME_SUPERVIEW) {
                        centerX = anotherView.center.x;
                        centerY = anotherView.center.y;
                    }
                } else {
                    CGPoint center = [value CGPointValue];
                    centerX = center.x;
                    centerY = center.y;
                }
                break;
            }
            case NMFrameTypeCenterX : {
                if (anotherView) {
                    if (IS_SUPERVIEW) {
                        centerX = anotherView.nm_width / 2;
                    } else if (IS_THE_SAME_SUPERVIEW) {
                        centerX = anotherView.center.x;
                    }
                } else if (number) {
                    centerX = number.floatValue;
                } else if (direction) {
                    centerX = direction.floatValue;
                }
                centerX += offset;
                break;
            }
            case NMFrameTypeCenterY : {
                if (anotherView) {
                    if (IS_SUPERVIEW) {
                        centerY = anotherView.nm_height / 2;
                    } else if (IS_THE_SAME_SUPERVIEW) {
                        centerY = anotherView.center.y;
                    }
                } else if (number) {
                    centerY = number.floatValue;
                } else if (direction) {
                    centerY = direction.floatValue;
                }
                centerY += offset;
                break;
            }
            case NMFrameTypeWidth : {
                if (anotherView) {
                    width = anotherView.nm_width;
                } else if (number) {
                    width = number.floatValue;
                }
                width *= multipliedBy;
                if (type.usingLessThanOrEqualTo) {
                    lessThanOrEqualToFrameType |= NMLessThanOrEqualToFrameTypeWidth;
                }
                if (type.usingGreaterThanOrEqualTo) {
                    greaterThanOrEqualToFrameType |= NMGreaterThanOrEqualToFrameTypeWidth;
                }
                break;
            }
            case NMFrameTypeHeight : {
                if (anotherView) {
                    height = anotherView.nm_height;
                } else {
                    height = number.floatValue;
                }
                height *= multipliedBy;
                if (type.usingGreaterThanOrEqualTo) {
                    greaterThanOrEqualToFrameType |= NMGreaterThanOrEqualToFrameTypeHeight;
                }
                break;
            }
            case NMFrameTypeSize : {
                if (anotherView) {
                    width = anotherView.nm_width;
                    height = anotherView.nm_height;
                } else {
                    CGSize size = [value CGSizeValue];
                    width = size.width;
                    height = size.height;
                }
                break;
            }
            case NMFrameTypeEdges : {
                if (anotherView) {
                    width = anotherView.nm_width;
                    height = anotherView.nm_height;
                }
                break;
            }
        }
    }
    
#define HAS_SET(__type)     (__type != CGFLOAT_MAX)
#define LESS_THAN_OR_EQUAL_TO(__lessThanOrEqualTo)          (lessThanOrEqualToFrameType & __lessThanOrEqualTo)
#define GREATER_THAN_OR_EQUAL_TO(__greaterThanOrEqualTo)    (greaterThanOrEqualToFrameType & __greaterThanOrEqualTo)
    
    if (LESS_THAN_OR_EQUAL_TO(NMLessThanOrEqualToFrameTypeWidth)) {
        //如果设置了最大宽度
        width = MIN(width, self.originalWidth);
    } else if (GREATER_THAN_OR_EQUAL_TO(NMGreaterThanOrEqualToFrameTypeWidth)) {
        //如果设置了最小宽度
        width = MAX(width, self.originalWidth);
    } else {
        width = HAS_SET(width) ? width : self.originalWidth;
    }
    
    if (GREATER_THAN_OR_EQUAL_TO(NMGreaterThanOrEqualToFrameTypeHeight)) {
        //如果设置了最小高度
        height = MAX(height, self.originalHeight);
    } else {
        height = HAS_SET(height) ? height : self.originalHeight;
    }
    
    if (HAS_SET(right)) {
        if (HAS_SET(left)) {
            width = right - left;
            if (LESS_THAN_OR_EQUAL_TO(NMLessThanOrEqualToFrameTypeRight)) {
                width = MIN(self.originalWidth, width);
            }
        } else {
            left = right - width;
        }
    } else {
        left = HAS_SET(left) ? left : 0;
    }
    
    if (HAS_SET(bottom)) {
        if (HAS_SET(top)) {
            height = bottom - top;
        } else {
            top = bottom - height;
        }
    } else {
        top = HAS_SET(top) ? top : 0;
    }
    
    self.view.bounds = CGRectMake(0, 0, width, height);
    self.view.center = CGPointMake(HAS_SET(centerX) ? centerX : (left + width / 2),
                                   HAS_SET(centerY) ? centerY : (top + height / 2));
    
    if (!CGRectEqualToRect(previousRect, self.view.frame)) {
        [self.view.frameDidUpdateSignal sendNext:nil];
    }
    if (!CGRectEqualToRect(previousBounds, self.view.bounds)) {
        [self.view.updateCombinationSignal sendNext:nil];
    }
}

#pragma mark - private methods

- (void)observeCustomUpdateFrameSignal {
    if (!self.view.customUpdateFrameSignal) {
        return;
    }
    if ([objc_getAssociatedObject(self.view, &kObserveCustomUpdateFrameKey) boolValue]) {
        return;
    }
    @weakify(self);
    [[self.view.customUpdateFrameSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self);
        [self.view sizeToFit];
        [self commit];
    }];
    objc_setAssociatedObject(self, &kObserveCustomUpdateFrameKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)addAndObserveRelativeView:(UIView *)relativeView {
    if ([self.view.nm_relativeViewHashTable containsObject:relativeView]) {
        return;
    }
    [self.view.nm_relativeViewHashTable addObject:relativeView];
    @weakify(self);
    [[relativeView.frameDidUpdateSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self);
        [self commit];
    }];
}

#pragma mark - getter

- (NSMutableDictionary<NSNumber *, NMFrameMakerType *> *)typesDictionary {
    if (!_typesDictionary) {
        _typesDictionary = [NSMutableDictionary dictionary];
    }
    return _typesDictionary;
}

@end
