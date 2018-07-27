//
//  NMFrameMakerOperation.h
//  NMFrameDemo
//
//  Created by 陈煜钏 on 2018/7/23.
//  Copyright © 2018年 陈煜钏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NMFrameMakerOperation : NSObject

@property (nonatomic, readonly, assign) CGFloat nm_offset;

@property (nonatomic, readonly, assign) CGFloat nm_multipliedBy;

- (void (^)(CGFloat))offset;

- (void (^)(CGFloat))multipliedBy;

@end
