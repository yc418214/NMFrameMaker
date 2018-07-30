//
//  ViewController.m
//  NMFrameDemo
//
//  Created by 陈煜钏 on 2018/7/20.
//  Copyright © 2018年 陈煜钏. All rights reserved.
//

#import "ViewController.h"

//header
#import "NMFrameHeader.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *labelOne;

@property (nonatomic, strong) UILabel *labelTwo;

@property (nonatomic, strong) UILabel *labelThree;

@property (nonatomic, strong) UILabel *labelFour;

@property (nonatomic, strong) UILabel *labelFive;

@property (nonatomic, strong) UIButton *buttonOne;

@property (nonatomic, strong) UIButton *buttonTwo;

@property (nonatomic, strong) UIView *viewOne;

@property (nonatomic, strong) UIView *viewTwo;

@property (nonatomic, strong) UIView *viewThree;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.imageView.image = [UIImage imageNamed:@"image"];
    [self.view addSubview:self.imageView];
    
    self.labelOne = [[UILabel alloc] initWithFrame:CGRectZero];
    self.labelOne.text = @"这是一个很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长的label";
    self.labelOne.layer.borderWidth = 1.f;
    [self.view addSubview:self.labelOne];
    
    self.labelTwo = [[UILabel alloc] initWithFrame:CGRectZero];
    self.labelTwo.text = @"这是一个很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长的label";
    self.labelTwo.layer.borderWidth = 1.f;
#warning 考虑放在外部设置还是内部默认YES
    self.labelTwo.nm_remakeWhenContentChange = YES;
    [self.view addSubview:self.labelTwo];

    self.labelThree = [[UILabel alloc] initWithFrame:CGRectZero];
    self.labelThree.text = @"这个label长度不少于260";
    self.labelThree.layer.borderWidth = 1.f;
    self.labelThree.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.labelThree];

    self.buttonOne = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.buttonOne setTitle:@"固定按钮" forState:UIControlStateNormal];
    self.buttonOne.layer.borderWidth = 1.f;
    self.buttonOne.layer.cornerRadius = 6.f;
    [self.buttonOne setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.buttonOne addTarget:self action:@selector(remakeFrame) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.buttonOne];

    self.buttonTwo = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.buttonTwo setTitle:@"自适应按钮" forState:UIControlStateNormal];
    self.buttonTwo.layer.borderWidth = 1.f;
    self.buttonTwo.layer.cornerRadius = 6.f;
    [self.buttonTwo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.buttonTwo.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.buttonTwo addTarget:self action:@selector(changeText) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.buttonTwo];

    self.viewOne = [[UIView alloc] initWithFrame:CGRectZero];
    self.viewOne.layer.borderWidth = 4.f;
    self.viewOne.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:self.viewOne];

    self.viewTwo = [[UIView alloc] initWithFrame:CGRectZero];
    self.viewTwo.layer.borderWidth = 8.f;
    self.viewTwo.layer.borderColor = [UIColor yellowColor].CGColor;
    [self.viewOne addSubview:self.viewTwo];

    self.viewThree = [[UIView alloc] initWithFrame:CGRectZero];
    self.viewThree.layer.borderWidth = 4.f;
    self.viewThree.layer.borderColor = [UIColor redColor].CGColor;
    [self.view addSubview:self.viewThree];
    
    self.labelFour = [[UILabel alloc] initWithFrame:CGRectZero];
    self.labelFour.text = @"top label";
    self.labelFour.layer.borderWidth = 1.f;
    [self.viewThree addSubview:self.labelFour];
    
    self.labelFive = [[UILabel alloc] initWithFrame:CGRectZero];
    self.labelFive.text = @"bottom label";
    self.labelFive.layer.borderWidth = 1.f;
    [self.viewThree addSubview:self.labelFive];
    
    NSInteger tag = 1;
    for (UIView *subview in self.view.subviews) {
        subview.tag = tag;
        tag++;
    }
}

static NSInteger layoutCount = 0;
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (layoutCount == 1) {
        return;
    }
    layoutCount++;
    
    [self.imageView nm_makeFrame:^(NMFrameMaker *make) {
        make.left.equalTo(self.view).offset(12);
        make.top.equalTo(self.view).offset(120);
    }];
    
    [self.labelOne nm_makeFrame:^(NMFrameMaker *make) {
        make.left.equalTo(self.imageView.nm_right).offset(12);
        make.right.lessThanOrEqualTo(self.view).offset(12);
        make.centerY.equalTo(self.imageView);
    }];
    
    [self.labelTwo nm_makeFrame:^(NMFrameMaker *make) {
        make.left.equalTo(self.imageView);
        make.width.nm_lessThanOrEqualTo(200);
        make.top.equalTo(self.imageView.nm_bottom).offset(12);
    }];
    
    [self.buttonOne nm_makeFrame:^(NMFrameMaker *make) {
        make.size.nm_equalTo(CGSizeMake(120, 40));
        make.left.equalTo(self.labelTwo);
        make.top.equalTo(self.labelTwo.nm_bottom).offset(12);
    }];
    
    [self.labelThree nm_makeFrame:^(NMFrameMaker *make) {
        make.width.nm_greaterThanOrEqualTo(260);
        make.left.equalTo(self.labelTwo);
        make.top.equalTo(self.buttonOne.nm_bottom).offset(12);
    }];
    
    [self.buttonTwo nm_makeFrame:^(NMFrameMaker *make) {
        make.center.equalTo(self.view);
    }];
    
    [self.viewOne nm_makeFrame:^(NMFrameMaker *make) {
        make.withWidth.withHeight.nm_equalTo(160);
        make.top.equalTo(self.buttonTwo.nm_bottom).offset(12);
        make.centerX.equalTo(self.view);
    }];
    
    [self.viewTwo nm_makeFrame:^(NMFrameMaker *make) {
        make.edges.equalTo(self.viewOne);
    }];
    
    [self.viewThree nm_makeFrame:^(NMFrameMaker *make) {
        make.width.equalTo(self.viewOne);
        make.height.equalTo(self.viewOne).multipliedBy(0.5);
        make.top.equalTo(self.viewOne.nm_bottom);
        make.centerX.equalTo(self.view);
    }];
    
    [UIView nm_combine:^(NMFrameCombination *combination) {
        combination.combine(self.labelFour).with(self.labelFive).verticalInView(self.viewThree).offset(12);
    }];
}

static NSInteger count = 0;
- (void)changeText {
    if (count % 2) {
        self.labelTwo.text = @"这是一个很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长的label";
        [self.imageView nm_updateFrame:^(NMFrameMaker *make) {
            make.left.equalTo(self.view).offset(12);
        }];
    } else {
        self.labelTwo.text = @"这是一个短label";
        [self.imageView nm_updateFrame:^(NMFrameMaker *make) {
            make.left.equalTo(self.view).offset(20);
        }];
    }
    count++;
    
    [self.viewThree nm_updateFrame:^(NMFrameMaker *make) {
        make.top.equalTo(self.viewOne.nm_bottom);
        make.height.equalTo(self.viewOne);
    }];
}

- (void)remakeFrame {
    [self.viewThree nm_remakeFrame:^(NMFrameMaker *make) {
        make.width.equalTo(self.viewOne);
        make.height.equalTo(self.viewOne).multipliedBy(0.5);
        make.top.equalTo(self.viewOne.nm_bottom).offset(12);
        make.centerX.equalTo(self.view);
    }];
}

@end
