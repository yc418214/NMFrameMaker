//
//  NMFrameMakerDirection.h
//  NMFrameDemo
//
//  Created by 陈煜钏 on 2018/7/26.
//  Copyright © 2018年 陈煜钏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NMFrameMakerDirectionType) {
    NMFrameMakerDirectionTypeLeft,
    NMFrameMakerDirectionTypeRight,
    NMFrameMakerDirectionTypeTop,
    NMFrameMakerDirectionTypeBottom
};

@interface NMFrameMakerDirection : NSObject

@property (nonatomic, readonly, weak) UIView *view;

@property (nonatomic, readonly, assign) CGFloat floatValue;

+ (instancetype)directionWithView:(UIView *)view
                             type:(NMFrameMakerDirectionType)type;

@end
