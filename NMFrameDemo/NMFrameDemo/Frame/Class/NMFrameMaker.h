//
//  NMFrameMaker.h
//  nimo
//
//  Created by 陈煜钏 on 2018/4/4.
//  Copyright © 2018年 HUYA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//type
#import "NMFrameMakerType.h"
//category
#import "UIView+NMAddition.h"
#import "UIView+RACSupport.h"

@interface NMFrameMaker : NSObject

@property (nonatomic, readonly, weak) UIView *view;

@property (nonatomic, readonly, strong) NSMutableDictionary<NSNumber *, NMFrameMakerType *> *typesDictionary;

@property (nonatomic, assign) NSInteger currentTag;

+ (instancetype)makerWithView:(UIView *)view;

- (void)commit;

@end
