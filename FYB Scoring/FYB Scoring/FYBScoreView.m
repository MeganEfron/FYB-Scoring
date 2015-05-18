//
//  FYBScoreView.m
//  FYB Scoring
//
//  Created by Megan Efron on 18/05/2015.
//  Copyright (c) 2015 Megan Efron. All rights reserved.
//

#import "FYBScoreView.h"
#import "UIColor+Extended.h"
#import "FYBEntry.h"
#import "FYBPlayer.h"

@interface FYBScoreView ()  <UITextInputTraits>

@property (strong, nonatomic) FYBEntry *entry;

@end

@implementation FYBScoreView

- (instancetype)initWithEntry:(FYBEntry *)entry {
    self = [super init];
    if (self) {
        self.entry = entry;
        [self setup];
    }
    
    return self;
}

- (void)setup {
    
    // -------------- Setting up views --------------
    self.betTextField = [UITextField new];
    self.madeTextField = [UITextField new];
    self.scoreLabel = [UILabel new];
    
    self.betTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.betTextField.returnKeyType = UIReturnKeyDone;
    
    self.madeTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.madeTextField.returnKeyType = UIReturnKeyDone;
    
    self.scoreLabel.font = [UIFont systemFontOfSize:[UIFont systemFontSize] + 7];
    
//    self.betTextField.text = self.entry.betValue ? [@(self.entry.betValue) stringValue] : @"";
//    self.madeTextField.text = self.entry.madeValue ? [@(self.entry.madeValue) stringValue] : @"";
    
    self.entry.betValue = [self.betTextField.text integerValue];
    self.entry.madeValue = [self.madeTextField.text integerValue];
    
    self.scoreLabel.text = self.entry.player.score ? [@(self.entry.player.score) stringValue] : @"";
    
    self.betTextField.textAlignment = NSTextAlignmentCenter;
    self.madeTextField.textAlignment = NSTextAlignmentCenter;
    self.scoreLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.betTextField];
    [self addSubview:self.madeTextField];
    [self addSubview:self.scoreLabel];
    
    [self.betTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(5);
        make.height.equalTo(self);
        make.width.mas_equalTo(@30);
    }];
    
    [self.madeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-5);
        make.height.equalTo(self);
        make.width.mas_equalTo(@30);
    }];
    
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.left.equalTo(self.betTextField.mas_right);
        make.right.equalTo(self.madeTextField.mas_left);
    }];
}

- (void)setPlaceholders {
	self.betTextField.placeholder = @"B";
    self.madeTextField.placeholder = @"M";
}

@end
