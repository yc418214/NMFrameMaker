//
//  NMFrameMaker+NMFrameType.m
//  nimo
//
//  Created by 陈煜钏 on 2018/4/4.
//  Copyright © 2018年 HUYA. All rights reserved.
//

#import "NMFrameMaker+NMFrameType.h"

@implementation NMFrameMaker (NMFrameType)

#pragma mark - Equal to

- (void (^)(id))equalTo {
    return ^(id object) {
        NSInteger tag = self.currentTag;
        for (NMFrameMakerType *type in self.typesDictionary.allValues) {
            if (type.tag == tag) {
                type.equalTo(object);
            }
        }
        self.currentTag = tag + 1;
    };
}

- (void (^)(id))nm_equalTo {
    return [self equalTo];
}

#define SAVE_AND_RETURN_TYPE(__type)    \
NMFrameMakerType *type = [NMFrameMakerType makerWithType:__type];  \
self.typesDictionary[@(__type)] = type; \
return type;    \

#define ADD_TYPE_AND_RETURN(__type) \
NMFrameMakerType *type = [NMFrameMakerType makerWithType:__type];  \
type.tag = self.currentTag;         \
self.typesDictionary[@(__type)] = type; \
return self;    \

#pragma mark - Type

- (NMFrameMakerType *)left {
    SAVE_AND_RETURN_TYPE(NMFrameTypeLeft);
}

- (NMFrameMakerType *)right {
    SAVE_AND_RETURN_TYPE(NMFrameTypeRight);
}

- (NMFrameMakerType *)top {
    SAVE_AND_RETURN_TYPE(NMFrameTypeTop);
}

- (NMFrameMakerType *)bottom {
    SAVE_AND_RETURN_TYPE(NMFrameTypeBottom);
}

- (NMFrameMakerType *)center {
    SAVE_AND_RETURN_TYPE(NMFrameTypeCenter);
}

- (NMFrameMakerType *)centerX {
    SAVE_AND_RETURN_TYPE(NMFrameTypeCenterX);
}

- (NMFrameMakerType *)centerY {
    SAVE_AND_RETURN_TYPE(NMFrameTypeCenterY);
}

- (NMFrameMakerType *)width {
    SAVE_AND_RETURN_TYPE(NMFrameTypeWidth);
}

- (NMFrameMakerType *)height {
    SAVE_AND_RETURN_TYPE(NMFrameTypeHeight);
}

- (NMFrameMakerType *)size {
    SAVE_AND_RETURN_TYPE(NMFrameTypeSize);
}

- (NMFrameMakerType *)edges {
    SAVE_AND_RETURN_TYPE(NMFrameTypeEdges);
}

#pragma mark - With

- (NMFrameMaker *)withLeft {
    ADD_TYPE_AND_RETURN(NMFrameTypeLeft);
}

- (NMFrameMaker *)withRight {
    ADD_TYPE_AND_RETURN(NMFrameTypeRight);
}

- (NMFrameMaker *)withTop {
    ADD_TYPE_AND_RETURN(NMFrameTypeTop);
}

- (NMFrameMaker *)withBottom {
    ADD_TYPE_AND_RETURN(NMFrameTypeBottom);
}

- (NMFrameMaker *)withCenter {
    ADD_TYPE_AND_RETURN(NMFrameTypeCenter);
}

- (NMFrameMaker *)withCenterX {
    ADD_TYPE_AND_RETURN(NMFrameTypeCenterX);
}

- (NMFrameMaker *)withCenterY {
    ADD_TYPE_AND_RETURN(NMFrameTypeCenterY);
}

- (NMFrameMaker *)withWidth {
    ADD_TYPE_AND_RETURN(NMFrameTypeWidth);
}

- (NMFrameMaker *)withHeight {
    ADD_TYPE_AND_RETURN(NMFrameTypeHeight);
}

- (NMFrameMaker *)withSize {
    ADD_TYPE_AND_RETURN(NMFrameTypeSize);
}

- (NMFrameMaker *)withEdges {
    ADD_TYPE_AND_RETURN(NMFrameTypeEdges);
}

@end
