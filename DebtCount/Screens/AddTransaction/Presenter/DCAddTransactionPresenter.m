//
//  DCAddTransactionPresenter.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 28/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCAddTransactionPresenter.h"

@interface DCAddTransactionPresenter ()

@property (weak) DCAddTransactionViewController *view;

@end

@implementation DCAddTransactionPresenter

- (instancetype)initWithView:(DCAddTransactionViewController *)view {
    if (self = [super init]) {
        self.view = view;
    }
    return self;
}

@end

// MARK: - Signals From View

@implementation DCAddTransactionPresenter (ViewInputs)

- (void)viewIsReady {
    [self.view setupCancelButtonWithText:[@"ADD_TRANSACTION_SCREEN.BUTTONS.CANCEL" localized]];
    [self.view setupOKButtonWithText:[@"ADD_TRANSACTION_SCREEN.BUTTONS.OK" localized]];
    [self.view setupAmountLabelTitle:[@"ADD_TRANSACTION_SCREEN.LABELS.AMOUNT" localized]];
    [self.view setupDateLabelTitle:[@"ADD_TRANSACTION_SCREEN.LABELS.DATE" localized]];
    [self.view setupDescriptionTitle:[@"ADD_TRANSACTION_SCREEN.LABELS.DESCRIPTION" localized]];
    
}

- (void)cancelButtonPressed {

}

- (void)okButtonPressed {

}

- (void)amountChangedWithText:(NSString *)text {

}

- (void)dateTextFieldPressed {

}

- (void)descriptionChangedText:(NSString *)text {

}

- (void)plusMinusButtonPressed {

}

@end
