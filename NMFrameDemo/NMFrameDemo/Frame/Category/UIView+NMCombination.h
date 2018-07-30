//
//  UIView+NMCombination.h
//  NMFrameDemo
//
//  Created by 陈煜钏 on 2018/7/30.
//  Copyright © 2018年 陈煜钏. All rights reserved.
//

#import <UIKit/UIKit.h>

//combination
#import "NMFrameCombination.h"

typedef void(^NMFrameCombinationBlock)(NMFrameCombination *combination);

@interface UIView (NMCombination)

/**
 同时布局两个subview
 
 @param makeBlock makeBlock
 */
+ (void)nm_combine:(NMFrameCombinationBlock)makeBlock;

- (void)updateCombination;

@end
