//
//  NMFrameMakerOperation.m
//  NMFrameDemo
//
//  Created by 陈煜钏 on 2018/7/23.
//  Copyright © 2018年 陈煜钏. All rights reserved.
//

#import "NMFrameMakerOperation.h"

@interface NMFrameMakerOperation ()

@property (nonatomic, readwrite, assign) CGFloat nm_offset;

@property (nonatomic, readwrite, assign) CGFloat nm_multipliedBy;

@end

@implementation NMFrameMakerOperation

- (instancetype)init {
    self = [super init];
    if (self) {
        _nm_multipliedBy = 1.f;
    }
    return self;
}

#pragma mark - public methods

- (void (^)(CGFloat))offset {
    return ^(CGFloat offset) {
        self.nm_offset = offset;
    };
}

- (void (^)(CGFloat))multipliedBy {
    return ^(CGFloat multipliedBy) {
        self.nm_multipliedBy = multipliedBy;
    };
}

@end
