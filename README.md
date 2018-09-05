# NMFrameMaker
Easy make frame.

````

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
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

````
