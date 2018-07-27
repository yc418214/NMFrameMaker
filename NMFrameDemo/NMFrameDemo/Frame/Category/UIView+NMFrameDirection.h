//
//  UIView+NMFrameDirection.h
//  NMFrameDemo
//
//  Created by 陈煜钏 on 2018/7/26.
//  Copyright © 2018年 陈煜钏. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NMFrameMakerDirection.h"

@interface UIView (NMFrameDirection)

@property (nonatomic, strong) NMFrameMakerDirection *nm_left;
@property (nonatomic, strong) NMFrameMakerDirection *nm_right;
@property (nonatomic, strong) NMFrameMakerDirection *nm_top;
@property (nonatomic, strong) NMFrameMakerDirection *nm_bottom;

@end
