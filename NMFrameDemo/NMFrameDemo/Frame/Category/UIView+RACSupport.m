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

- (RACSubject *)boundsDidUpdateSignal {
    RACSubject *boundsDidUpdateSignal = objc_getAssociatedObject(self, @selector(boundsDidUpdateSignal));
    if (!boundsDidUpdateSignal) {
        boundsDidUpdateSignal = [RACSubject subject];
        self.boundsDidUpdateSignal = boundsDidUpdateSignal;
    }
    return boundsDidUpdateSignal;
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

- (void)setBoundsDidUpdateSignal:(RACSubject *)boundsDidUpdateSignal {
    objc_setAssociatedObject(self,
                             @selector(boundsDidUpdateSignal),
                             boundsDidUpdateSignal,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setNm_relativeViewHashTable:(NSHashTable *)nm_relativeViewHashTable {
    objc_setAssociatedObject(self,
                             @selector(nm_relativeViewHashTable),
                             nm_relativeViewHashTable,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
