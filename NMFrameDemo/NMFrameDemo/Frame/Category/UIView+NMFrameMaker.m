//
//  UIView+NMFrameMaker.m
//  nimo
//
//  Created by 陈煜钏 on 2018/4/4.
//  Copyright © 2018年 HUYA. All rights reserved.
//

#import "UIView+NMFrameMaker.h"

#import <objc/runtime.h>
//vendor
#import <ReactiveObjC/ReactiveObjC.h>

@interface UIView ()

@property (nonatomic, strong) NMFrameMaker *nm_frameMaker;

@end

@implementation UIView (NMFrameMaker)

- (void)nm_makeFrame:(NMMakeFrameBlock)makeBlock {
    if (!makeBlock) {
        return;
    }
    if (self.nm_frameMaker) {
        [self.nm_frameMaker commit];
        return;
    }
    NMFrameMaker *maker = [NMFrameMaker makerWithView:self];
    makeBlock(maker);
    [maker commit];
    self.nm_frameMaker = maker;
    
    if (!self.nm_remakeWhenContentChange) {
        return;
    }
    
    @weakify(self);
    if ([self isKindOfClass:[UILabel class]]) {
        [[RACObserve(((UILabel *)self), text) skip:1] subscribeNext:^(id x) {
            @strongify(self);
            [self sizeToFit];
            [self updateLayout];
        }];
    } else if ([self isKindOfClass:[UIButton class]]) {
        [[RACObserve(((UIButton *)self).titleLabel, text) skip:1] subscribeNext:^(id x) {
            @strongify(self);
            [self sizeToFit];
            [self updateLayout];
        }];
    }
}

- (void)nm_updateFrame:(NMMakeFrameBlock)makeBlock {
    if (!makeBlock) {
        return;
    }
    if (!self.nm_frameMaker) {
        return;
    }
    [self.nm_relativeViewHashTable removeAllObjects];
    makeBlock(self.nm_frameMaker);
    [self.nm_frameMaker commit];
}

- (void)nm_remakeFrame:(NMMakeFrameBlock)makeBlock {
    self.nm_frameMaker = nil;
    [self.nm_relativeViewHashTable removeAllObjects];
    [self nm_makeFrame:makeBlock];
}

#pragma mark - private methods

- (void)updateLayout {
    if (self.nm_frameMaker) {
        [self.nm_frameMaker commit];
    }
}

#pragma mark - getter

- (NMFrameMaker *)nm_frameMaker {
    return objc_getAssociatedObject(self, @selector(nm_frameMaker));
}

- (BOOL)nm_remakeWhenContentChange {
    return [objc_getAssociatedObject(self, @selector(nm_remakeWhenContentChange)) boolValue];
}

#pragma mark - setter

- (void)setNm_frameMaker:(NMFrameMaker *)nm_frameMaker {
    objc_setAssociatedObject(self,
                             @selector(nm_frameMaker),
                             nm_frameMaker,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setNm_remakeWhenContentChange:(BOOL)nm_remakeWhenContentChange {
    objc_setAssociatedObject(self,
                             @selector(nm_remakeWhenContentChange),
                             @(nm_remakeWhenContentChange),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
