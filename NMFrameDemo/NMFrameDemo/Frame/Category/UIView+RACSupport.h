//
//  UIView+RACSupport.h
//  NMFrameDemo
//
//  Created by 陈煜钏 on 2018/7/26.
//  Copyright © 2018年 陈煜钏. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <ReactiveObjC/ReactiveObjC.h>

@interface UIView (RACSupport)

@property (nonatomic, strong) RACSubject *boundsDidUpdateSignal;

@property (nonatomic, strong) NSHashTable *nm_relativeViewHashTable;

@end
