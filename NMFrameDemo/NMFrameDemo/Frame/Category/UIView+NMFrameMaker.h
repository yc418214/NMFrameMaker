//
//  UIView+NMFrameMaker.h
//  nimo
//
//  Created by 陈煜钏 on 2018/4/4.
//  Copyright © 2018年 HUYA. All rights reserved.
//

#import <UIKit/UIKit.h>

//category
#import "NMFrameMaker+NMFrameType.h"
#import "UIView+NMFrameDirection.h"

typedef void(^NMMakeFrameBlock)(NMFrameMaker *make);

@interface UIView (NMFrameMaker)

@property (nonatomic, assign) BOOL nm_remakeWhenContentChange;

- (void)nm_makeFrame:(NMMakeFrameBlock)makeBlock;

/**
 更新布局中的某一项
 
 @param makeBlock makeBlock
 */
- (void)nm_updateFrame:(NMMakeFrameBlock)makeBlock;

/**
 重新布局
 注意：如果makeBlock的依赖的view可能会变，使用此方法
 
 @param makeBlock makeBlock
 */
- (void)nm_remakeFrame:(NMMakeFrameBlock)makeBlock;

@end
