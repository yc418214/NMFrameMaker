//
//  UIView+NMCombination.m
//  NMFrameDemo
//
//  Created by 陈煜钏 on 2018/7/30.
//  Copyright © 2018年 陈煜钏. All rights reserved.
//

#import "UIView+NMCombination.h"

//category
#import "UIView+RACSupport.h"

@implementation UIView (NMCombination)

+ (void)nm_combine:(NMFrameCombinationBlock)makeBlock {
    NMFrameCombination *frameCombination = [[NMFrameCombination alloc] init];
    makeBlock(frameCombination);
    [frameCombination commit];
}

- (void)updateCombination {
    [self.updateCombinationSignal sendNext:nil];
}

@end
