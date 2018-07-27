//
//  NMFrameMaker+NMFrameType.h
//  nimo
//
//  Created by 陈煜钏 on 2018/4/4.
//  Copyright © 2018年 HUYA. All rights reserved.
//

#import "NMFrameMaker.h"

@interface NMFrameMaker (NMFrameType)

- (void (^)(id))equalTo;
- (void (^)(id))nm_equalTo;

- (NMFrameMakerType *)left;
- (NMFrameMakerType *)right;
- (NMFrameMakerType *)top;
- (NMFrameMakerType *)bottom;
- (NMFrameMakerType *)center;
- (NMFrameMakerType *)centerX;
- (NMFrameMakerType *)centerY;
- (NMFrameMakerType *)width;
- (NMFrameMakerType *)height;
- (NMFrameMakerType *)size;
- (NMFrameMakerType *)edges;

- (NMFrameMaker *)withLeft;
- (NMFrameMaker *)withRight;
- (NMFrameMaker *)withTop;
- (NMFrameMaker *)withBottom;
- (NMFrameMaker *)withCenter;
- (NMFrameMaker *)withCenterX;
- (NMFrameMaker *)withCenterY;
- (NMFrameMaker *)withWidth;
- (NMFrameMaker *)withHeight;
- (NMFrameMaker *)withSize;
- (NMFrameMaker *)withEdges;

@end
