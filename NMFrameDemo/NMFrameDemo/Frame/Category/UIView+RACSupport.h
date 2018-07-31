//
//  UIView+RACSupport.h
//  NMFrameDemo
//
//  Created by 陈煜钏 on 2018/7/26.
//  Copyright © 2018年 陈煜钏. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <ReactiveObjC/ReactiveObjC.h>

#define NM_CUSTOM_UPDATE_FRAME_SIGNAL(__object, __selector)     [__object rac_signalForSelector:@selector(__selector)]

@interface UIView (RACSupport)

@property (nonatomic, strong) RACSignal *customUpdateFrameSignal;

@property (nonatomic, readonly, strong) RACSubject *frameDidUpdateSignal;

@property (nonatomic, readonly, strong) RACSubject *updateCombinationSignal;

@property (nonatomic, readonly, strong) NSHashTable *nm_relativeViewHashTable;

@end
