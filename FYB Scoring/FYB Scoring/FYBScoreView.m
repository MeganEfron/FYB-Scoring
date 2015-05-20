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
#import "FYBScoringTableViewController.h"
#import "FYBPlayer+Extended.h"
#import "FYBRound.h"

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
    self.scoreLabel.font = [UIFont systemFontOfSize:27];
    self.madeTextField.font = [UIFont systemFontOfSize:20];
    self.betTextField.font = [UIFont systemFontOfSize:20];
    
    self.betTextField.placeholder = @"B";
    self.madeTextField.placeholder = @"M";
    
    // Adding targets to text fields
    self.betTextField.delegate = self;
    self.madeTextField.delegate = self;
    
    // Displaying the score
    self.madeTextField.text = self.entry.madeValue ? [@(self.entry.madeValue) stringValue] : @"";
    self.betTextField.text = self.entry.betValue ? [@(self.entry.betValue) stringValue] : @"";
    self.scoreLabel.text = self.entry.scoreForEntry ? [@(self.entry.scoreForEntry) stringValue] : @"";
    
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
        make.left.equalTo(self).with.offset(3);
        make.height.equalTo(self);
        make.width.mas_equalTo(@30);
    }];
    
    [self.madeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-3);
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
    
    NSInteger previousBet = self.entry.betValue;
    NSInteger previousMade = self.entry.madeValue;
    
    // If the textfield is the BET text field
    if (textField == self.betTextField)
    {
        self.entry.betValue = [textField.text integerValue];
    }
    
    // If the textfield is the MADE text field
    else if (textField == self.madeTextField)
    {
        self.entry.madeValue = [textField.text integerValue];
    }
    
    // Calculating score and displaying
    if (self.entry.betValue && self.entry.madeValue)
    {
        
        if (previousBet && previousMade)
        {
            NSInteger scoreToSubtract = -[self calculateScoreFromBet:previousBet made:previousMade];
            
            NSInteger score = [self.entry.player.score integerValue];
            
            score += scoreToSubtract;
            
            self.entry.player.score = @(score);
        }
        
        NSInteger scoreToAdd = [self calculateScoreFromBet:self.entry.betValue made:self.entry.madeValue];
        
        [self.entry.player addToScore:scoreToAdd];
        self.entry.scoreForEntry = [self.entry.player.score integerValue];
        
        self.scoreLabel.text = [@(self.entry.scoreForEntry) stringValue];
    }
    
    if (self.entry.entryIndex == self.entry.round.lastPlayer && textField == self.betTextField)
    {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Can't Go" message:nil preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction *okayAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
//        
//        [alert addAction:okayAction];
    }
    
    if (self.entry.entryIndex == self.entry.round.lastPlayer && textField == self.madeTextField)
    {
        NSLog(@"Last entry");
    }
    
    if ([[FYBGameManager sharedManager] isRoundFinished:self.entry.round])
    {
        [[FYBGameManager sharedManager] nextRound];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationNextRound object:nil];
    }
    
    return YES;
}


- (NSInteger) calculateScoreFromBet:(NSInteger)bet made:(NSInteger)made {
    NSInteger score;
    
    if (bet == made)
        score = bet * made + 10;
    else
    {
        score = (bet - made) * 2;
        if (score > 0)
        {
            score = -score;
        }
    }
    
    return score;
}


@end
