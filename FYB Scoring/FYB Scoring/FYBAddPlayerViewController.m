//
//  FYBAddPlayerViewController.m
//  FYB Scoring
//
//  Created by Megan Efron on 19/05/2015.
//  Copyright (c) 2015 Megan Efron. All rights reserved.
//

#import "FYBAddPlayerViewController.h"

@interface FYBAddPlayerViewController ()

@end

@implementation FYBAddPlayerViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupView];
    
}

- (void)setupView {
    
    
    UIView *superview = self.view;
    
    superview.backgroundColor = [UIColor whiteColor];
    
    // ----- View Init -----
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [superview addSubview:cancelButton];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [addButton addTarget:self action:@selector(addPlayer) forControlEvents:UIControlEventTouchUpInside];
    addButton.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
    [addButton setTitle:@"Add Player" forState:UIControlStateNormal];
    [superview addSubview:addButton];
    
    // ----- View Constraints -----
    
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superview).multipliedBy(0.5);
        make.bottom.equalTo(superview).with.offset(-50);
    }];
    
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superview).multipliedBy(1.5);
        make.bottom.equalTo(superview).with.offset(-50);
    }];
}


- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addPlayer {
    NSLog(@"Add Player");
}

@end
