//
//  NMFrameMakerType.m
//  YCTestProject
//
//  Created by 陈煜钏 on 2018/7/2.
//  Copyright © 2018年 陈煜钏. All rights reserved.
//

#import "NMFrameMakerType.h"

//category
#import "UIView+NMAddition.h"

@interface NMFrameMakerType ()

@property (nonatomic, readwrite, assign) NMFrameType currentType;

@property (nonatomic, readwrite, strong) NMFrameMakerOperation *makerOperation;

@property (nonatomic, readwrite, weak) UIView *anotherView;

@property (nonatomic, readwrite, strong) NSNumber *number;

@property (nonatomic, readwrite, strong) NSValue *value;

@property (nonatomic, readwrite, strong) NMFrameMakerDirection *direction;

@end

@implementation NMFrameMakerType

+ (instancetype)makerWithType:(NMFrameType)type {
    NMFrameMakerType *makerType = [[NMFrameMakerType alloc] init];
    makerType.currentType = type;
    return makerType;
}

- (NMFrameMakerOperation *(^)(id))equalTo {
    return ^(id object) {
        UIView *anotherView;
        NSNumber *number;
        NSValue *value;
        NMFrameMakerDirection *direction;
        
        if ([[object class] isSubclassOfClass:[UIView class]]) {
            anotherView = (UIView *)object;
        } else if ([object isKindOfClass:[NSNumber class]]) {
            number = (NSNumber *)object;
        } else if ([object isKindOfClass:[NSValue class]]) {
            value = (NSValue *)object;
        } else if ([object isKindOfClass:[NMFrameMakerDirection class]]) {
            direction = (NMFrameMakerDirection *)object;
        }
        
        NSAssert(!(!anotherView && !number && !value && !direction), @"Equal to unknown object");
        
        self.anotherView = anotherView;
        self.number = number;
        self.value = value;
        self.direction = direction;
        
        return self.makerOperation;
    };
}

- (NMFrameMakerOperation *(^)(id))nm_equalTo {
    return [self equalTo];
}

- (NMFrameMakerOperation *(^)(id))lessThanOrEqualTo {
    return ^(id object) {
        if (self.currentType != NMFrameTypeWidth &&
            self.currentType != NMFrameTypeRight) {
            return self.makerOperation;
        }
        UIView *anotherView;
        NSNumber *number;
        NMFrameMakerDirection *direction;
        
        if ([[object class] isSubclassOfClass:[UIView class]]) {
            anotherView = (UIView *)object;
        } else if ([object isKindOfClass:[NSNumber class]]) {
            number = (NSNumber *)object;
        } else if ([object isKindOfClass:[NMFrameMakerDirection class]]) {
            direction = (NMFrameMakerDirection *)object;
        }
        
        NSAssert(!(!anotherView && !number && !direction), @"LessThanOrEqualTo to unknown object");
        
        self.anotherView = anotherView;
        self.number = number;
        self.direction = direction;
        self.usingLessThanOrEqualTo = YES;
        
        return self.makerOperation;
    };
}

- (NMFrameMakerOperation *(^)(id))nm_lessThanOrEqualTo {
    return [self lessThanOrEqualTo];
}

- (NMFrameMakerOperation *(^)(id))greaterThanOrEqualTo {
    return ^(id object) {
        if (self.currentType != NMFrameTypeWidth &&
            self.currentType != NMFrameTypeHeight) {
            return self.makerOperation;
        }
        UIView *anotherView;
        NSNumber *number;
        
        if ([[object class] isSubclassOfClass:[UIView class]]) {
            anotherView = (UIView *)object;
        } else if ([object isKindOfClass:[NSNumber class]]) {
            number = (NSNumber *)object;
        }
        
        NSAssert(!(!anotherView && !number), @"GreaterThanOrEqualTo to unknown object");
        
        self.anotherView = anotherView;
        self.number = number;
        self.usingGreaterThanOrEqualTo = YES;
        
        return self.makerOperation;
    };
}

- (NMFrameMakerOperation *(^)(id))nm_greaterThanOrEqualTo {
    return [self greaterThanOrEqualTo];
}

#pragma mark - getter

- (NMFrameMakerOperation *)makerOperation {
    if (!_makerOperation) {
        _makerOperation = [[NMFrameMakerOperation alloc] init];
    }
    return _makerOperation;
}

@end
