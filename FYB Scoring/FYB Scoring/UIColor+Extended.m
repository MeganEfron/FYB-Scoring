//
//  UIColor+Extended.m
//  FYB Scoring
//
//  Created by Megan Efron on 13/05/2015.
//  Copyright (c) 2015 Megan Efron. All rights reserved.
//

#import "UIColor+Extended.h"

@implementation UIColor (Extended)


+ (UIColor*)defaultTextColor {
    return [UIColor whiteColor];
}

+ (UIColor*)backgroundColor {
    return [UIColor colorWithWhite:0.3 alpha:1.000];
}

+ (UIColor*)randomColor {
    
    int randomR = arc4random_uniform(255);
    int randomG = arc4random_uniform(255);
    int randomB = arc4random_uniform(255);
    
    UIColor *randomColour = [UIColor colorWithRed:(float)randomR/255 green:(float)randomG/255 blue:(float)randomB/255 alpha:1];
    
    return randomColour;
}

@end
