//
//  NMFrameMakerType.h
//  YCTestProject
//
//  Created by 陈煜钏 on 2018/7/2.
//  Copyright © 2018年 陈煜钏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//macros
#import "NMFrameMacros.h"
//operation
#import "NMFrameMakerOperation.h"
//direction
#import "NMFrameMakerDirection.h"

typedef NS_ENUM(NSInteger, NMFrameType) {
    NMFrameTypeNone,
    NMFrameTypeLeft,
    NMFrameTypeRight,
    NMFrameTypeTop,
    NMFrameTypeBottom,
    NMFrameTypeCenter,
    NMFrameTypeCenterX,
    NMFrameTypeCenterY,
    NMFrameTypeWidth,
    NMFrameTypeHeight,
    NMFrameTypeSize,
    NMFrameTypeEdges
};

static inline id _NMBoxValue(const char *type, ...);

#define nm_equalTo(...)                 equalTo(NMBoxValue((__VA_ARGS__)))
#define nm_lessThanOrEqualTo(...)       lessThanOrEqualTo(NMBoxValue((__VA_ARGS__)))
#define nm_greaterThanOrEqualTo(...)    greaterThanOrEqualTo(NMBoxValue((__VA_ARGS__)))

@interface NMFrameMakerType : NSObject

@property (nonatomic, readonly, assign) NMFrameType currentType;

@property (nonatomic, readonly, strong) NMFrameMakerOperation *makerOperation;

@property (nonatomic, readonly, weak) UIView *anotherView;

@property (nonatomic, readonly, strong) NSNumber *number;

@property (nonatomic, readonly, strong) NSValue *value;

@property (nonatomic, readonly, strong) NMFrameMakerDirection *direction;

@property (nonatomic, assign) BOOL usingLessThanOrEqualTo;

@property (nonatomic, assign) BOOL usingGreaterThanOrEqualTo;

@property (nonatomic, assign) NSInteger tag;

+ (instancetype)makerWithType:(NMFrameType)type;

- (NMFrameMakerOperation *(^)(id))equalTo;

- (NMFrameMakerOperation *(^)(id))nm_equalTo;

- (NMFrameMakerOperation *(^)(id))lessThanOrEqualTo;

- (NMFrameMakerOperation *(^)(id))nm_lessThanOrEqualTo;

- (NMFrameMakerOperation *(^)(id))greaterThanOrEqualTo;

- (NMFrameMakerOperation *(^)(id))nm_greaterThanOrEqualTo;

@end
