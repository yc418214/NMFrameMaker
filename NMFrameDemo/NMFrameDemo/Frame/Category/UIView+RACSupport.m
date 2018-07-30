//
//  UIView+RACSupport.m
//  NMFrameDemo
//
//  Created by 陈煜钏 on 2018/7/26.
//  Copyright © 2018年 陈煜钏. All rights reserved.
//

#import "UIView+RACSupport.h"

#import <objc/runtime.h>

@implementation UIView (RACSupport)

#pragma mark - getter

- (RACSubject *)frameDidUpdateSignal {
    RACSubject *frameDidUpdateSignal = objc_getAssociatedObject(self, @selector(frameDidUpdateSignal));
    if (!frameDidUpdateSignal) {
        frameDidUpdateSignal = [RACSubject subject];
        self.frameDidUpdateSignal = frameDidUpdateSignal;
    }
    return frameDidUpdateSignal;
}

- (RACSubject *)updateCombinationSignal {
    RACSubject *updateCombinationSignal = objc_getAssociatedObject(self, @selector(updateCombinationSignal));
    if (!updateCombinationSignal) {
        updateCombinationSignal = [RACSubject subject];
        self.updateCombinationSignal = updateCombinationSignal;
    }
    return updateCombinationSignal;
}

- (NSHashTable *)nm_relativeViewHashTable {
    NSHashTable *relativeViewHashTable = objc_getAssociatedObject(self, @selector(nm_relativeViewHashTable));
    if (!relativeViewHashTable) {
        relativeViewHashTable = [NSHashTable weakObjectsHashTable];
        self.nm_relativeViewHashTable = relativeViewHashTable;
    }
    return relativeViewHashTable;
}

#pragma mark - setter

- (void)setFrameDidUpdateSignal:(RACSubject *)frameDidUpdateSignal {
    objc_setAssociatedObject(self,
                             @selector(frameDidUpdateSignal),
                             frameDidUpdateSignal,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setUpdateCombinationSignal:(RACSubject *)updateCombinationSignal {
    objc_setAssociatedObject(self,
                             @selector(updateCombinationSignal),
                             updateCombinationSignal,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setNm_relativeViewHashTable:(NSHashTable *)nm_relativeViewHashTable {
    objc_setAssociatedObject(self,
                             @selector(nm_relativeViewHashTable),
                             nm_relativeViewHashTable,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
