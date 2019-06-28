//
//  AddPersonTextField.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 21/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "AddTextField.h"

@interface AddTextField (AddPersonTextFieldUISetup)

- (void)setupUI;

@end

@implementation AddTextField

- (void)drawRect:(CGRect)rect {
    [self setupUI];
}

- (void)changeStyleToError {
    [self.layer setBorderColor:UIColor.redColor.CGColor];
}

- (void)changeStyleToValid {
    [self.layer setBorderColor:UIColor.blueColor.CGColor];
}

@end

@implementation AddTextField (AddPersonTextFieldUISetup)

- (void)setupUI {
    [self.layer setBorderWidth:1.0];
    [self.layer setBorderColor:UIColor.blueColor.CGColor];
    [self.layer setCornerRadius:self.bounds.size.height / 2];
    [self.layer setMasksToBounds:true];
}

@end
