//
//  FYBBaseViewController.m
//  FYB Scoring
//
//  Created by Megan Efron on 13/05/2015.
//  Copyright (c) 2015 Megan Efron. All rights reserved.
//

#import "FYBBaseViewController.h"
#import "UIColor+Extended.h"

@interface FYBBaseViewController ()

@end

@implementation FYBBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setting the background colour to charcoal grey
    self.view.backgroundColor = [UIColor backgroundColor];
    
    self.navigationController.navigationBar.translucent = NO;
}


@end
