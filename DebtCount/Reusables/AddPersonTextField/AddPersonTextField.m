//
//  AddPersonTextField.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 21/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "AddPersonTextField.h"

@interface AddPersonTextField (AddPersonTextFieldUISetup)

- (void)setupUI;

@end

@implementation AddPersonTextField

- (void)drawRect:(CGRect)rect {
    [self setupUI];
}

@end

@implementation AddPersonTextField (AddPersonTextFieldUISetup)

- (void)setupUI {
    [self.layer setBorderWidth:1.0];
    [self.layer setBorderColor:UIColor.blueColor.CGColor];
    [self.layer setCornerRadius:self.bounds.size.height / 2];
    [self.layer setMasksToBounds:true];
}

@end
