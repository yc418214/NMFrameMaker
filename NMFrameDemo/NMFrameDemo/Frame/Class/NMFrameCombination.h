//
//  NMFrameCombination.h
//  NMFrameDemo
//
//  Created by 陈煜钏 on 2018/7/30.
//  Copyright © 2018年 陈煜钏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//operation
#import "NMFrameMakerOperation.h"

@interface NMFrameCombination : NSObject

- (NMFrameCombination *(^)(UIView *))combine;

- (NMFrameCombination *(^)(UIView *))with;

- (NMFrameMakerOperation *(^)(UIView *))horizontalInView;

- (NMFrameMakerOperation *(^)(UIView *))verticalInView;

- (void)commit;

@end
