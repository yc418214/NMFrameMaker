//
//  NMFrameCombination.m
//  NMFrameDemo
//
//  Created by 陈煜钏 on 2018/7/30.
//  Copyright © 2018年 陈煜钏. All rights reserved.
//

#import "NMFrameCombination.h"

#import <objc/runtime.h>
//category
#import "UIView+NMFrameMaker.h"
#import "UIView+RACSupport.h"

typedef NS_ENUM(NSInteger, NMFrameCombinationType) {
    NMFrameCombinationTypeNone,
    NMFrameCombinationTypeVertical,
    NMFrameCombinationTypeHorizontal
};

static char *kFrameCombinationKey;
static char *kBindFrameCombinationKey;

@interface NMFrameCombination ()

@property (nonatomic, weak) UIView *firstView;

@property (nonatomic, weak) UIView *anotherView;

@property (nonatomic, weak) UIView *superView;

@property (nonatomic, strong) NMFrameMakerOperation *operation;

@property (nonatomic, assign) NMFrameCombinationType combinationType;

@end

@implementation NMFrameCombination

- (NMFrameCombination *(^)(UIView *))combine {
    return ^(UIView *view) {
        self.firstView = view;
        return self;
    };
}

- (NMFrameCombination *(^)(UIView *))with {
    return ^(UIView *view) {
        self.anotherView = view;
        return self;
    };
}

- (NMFrameMakerOperation *(^)(UIView *))horizontalInView {
    return ^(UIView *superView) {
        self.combinationType = NMFrameCombinationTypeHorizontal;
        self.superView = superView;
        [self bindFrameCombinationWithView:self.superView];
        return self.operation;
    };
}

- (NMFrameMakerOperation *(^)(UIView *))verticalInView {
    return ^(UIView *superView) {
        self.combinationType = NMFrameCombinationTypeVertical;
        self.superView = superView;
        [self bindFrameCombinationWithView:self.superView];
        return self.operation;
    };
}

- (void)commit {
    NSAssert(self.combinationType != NMFrameCombinationTypeNone, @"Combination type error");
    NSAssert((self.firstView.superview == self.superView) && (self.anotherView.superview == self.superView),
             @"Combination superView Error");
    
    [self.firstView sizeToFit];
    [self.anotherView sizeToFit];
    
    [self update];
}

#pragma mark - private methods

- (void)update {
    switch (self.combinationType) {
        case NMFrameCombinationTypeVertical: {
            [self layoutVerticalWithView:self.firstView
                             anotherView:self.anotherView];
            break;
        }
        case NMFrameCombinationTypeHorizontal: {
            [self layoutHorizontalWithView:self.firstView
                               anotherView:self.anotherView];
            break;
        }
        case NMFrameCombinationTypeNone: {
            break;
        }
    }
}

- (void)bindFrameCombinationWithView:(UIView *)view {
    objc_setAssociatedObject(view, &kFrameCombinationKey, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([objc_getAssociatedObject(view, &kBindFrameCombinationKey) boolValue]) {
        return;
    }
    @weakify(view);
    [view.updateCombinationSignal subscribeNext:^(id x) {
        @strongify(view);
        NMFrameCombination *combination = objc_getAssociatedObject(view, &kFrameCombinationKey);
        [combination update];
    }];
    objc_setAssociatedObject(view, &kBindFrameCombinationKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)layoutHorizontalWithView:(UIView *)view anotherView:(UIView *)anotherView {
    UIView *superView = self.superView;
    CGFloat offset = self.operation.nm_offset;
    CGFloat viewMaxWidth = (superView.nm_width - offset) / 2;
    
    view.nm_width = MIN(view.nm_width, viewMaxWidth);
    view.nm_centerX = (superView.nm_width - offset - view.nm_width) / 2;
    view.nm_centerY = superView.nm_height / 2;
    
    anotherView.nm_width = MIN(anotherView.nm_width, viewMaxWidth);
    anotherView.nm_x = view.nm_right.floatValue + offset;
    anotherView.nm_centerY = view.nm_centerY;
}

- (void)layoutVerticalWithView:(UIView *)view anotherView:(UIView *)anotherView {
    UIView *superView = self.superView;
    CGFloat offset = self.operation.nm_offset;
    CGFloat totalHeight = view.nm_height + offset + anotherView.nm_height;
    CGFloat minY = (superView.nm_height - totalHeight) / 2;
    
    view.nm_width = MIN(view.nm_width, superView.nm_width);
    view.nm_y = minY;
    view.nm_centerX = superView.nm_width / 2;
    
    anotherView.nm_width = MIN(anotherView.nm_width, superView.nm_width);
    anotherView.nm_y = view.nm_bottom.floatValue + offset;
    anotherView.nm_centerX = view.nm_centerX;
}

#pragma mark - getter

- (NMFrameMakerOperation *)operation {
    if (!_operation) {
        _operation = [[NMFrameMakerOperation alloc] init];
    }
    return _operation;
}

@end
