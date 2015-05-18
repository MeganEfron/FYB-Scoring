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

@interface FYBScoreView ()  <UITextFieldDelegate>

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
    
    // Initializing views
    self.betTextField = [UITextField new];
    self.madeTextField = [UITextField new];
    self.scoreLabel = [UILabel new];
    
    // Setting up keyboards for text fields (to number keyboards)
    self.betTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.betTextField.returnKeyType = UIReturnKeyDone;
    
    self.madeTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.madeTextField.returnKeyType = UIReturnKeyDone;
    
    // Setting the font of the score to be larger than the text fields
    self.scoreLabel.font = [UIFont systemFontOfSize:[UIFont systemFontSize] + 7];
    
    // Adding targets to text fields
    self.betTextField.delegate = self;
    self.madeTextField.delegate = self;
    
    // Giving the value entered into the model entry
//    self.entry.betValue = [self.betTextField.text integerValue];
//    self.entry.madeValue = [self.madeTextField.text integerValue];
    
    // Displaying the score
//    self.scoreLabel.text = self.entry.player.score ? [@(self.entry.player.score) stringValue] : @"";
    
    // Aligning all text to the center
    self.betTextField.textAlignment = NSTextAlignmentCenter;
    self.madeTextField.textAlignment = NSTextAlignmentCenter;
    self.scoreLabel.textAlignment = NSTextAlignmentCenter;
    
    // Adding views to self
    [self addSubview:self.betTextField];
    [self addSubview:self.madeTextField];
    [self addSubview:self.scoreLabel];
    
    
    
    // -------------- View Constraints --------------
    
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    if (textField == self.betTextField)
    {
        self.entry.betValue = [textField.text integerValue];
        NSLog(@"Setting entry to %i", self.entry.betValue);
    }
    else if (textField == self.madeTextField)
    {
        self.entry.madeValue = [textField.text integerValue];
        NSLog(@"Setting entry to %i", self.entry.madeValue);
    }
    
    // Calculating score and displaying
    if (self.entry.betValue && self.entry.madeValue)
    {
        NSInteger scoreToAdd;
        
        if (self.entry.betValue == self.entry.madeValue)
        {
            scoreToAdd = self.entry.betValue * self.entry.betValue + 10;
        }
        else
        {
            scoreToAdd = (self.entry.betValue - self.entry.madeValue) * 2;
            if (scoreToAdd > 0)
            {
                scoreToAdd = -scoreToAdd;
            }
        }
        
        [self.entry.player addToScore:scoreToAdd];
        
        self.scoreLabel.text = [@(self.entry.player.score) stringValue];
    }
    
    return YES;
}


- (void)setPlaceholders {
	self.betTextField.placeholder = @"B";
    self.madeTextField.placeholder = @"M";
}

@end
