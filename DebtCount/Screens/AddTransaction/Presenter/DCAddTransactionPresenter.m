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
@property id<DCValidatorProtocol> validator;
@property DCTransaction *transaction;

@property NSString *amount;
@property BOOL isAmountNegative;

@end

@implementation DCAddTransactionPresenter

- (instancetype)initWithView:(DCAddTransactionViewController *)view validator:(id<DCValidatorProtocol>)validator {
    if (self = [super init]) {
        self.validator = validator;
        self.view = view;
    }
    return self;
}

@end

// MARK: - Signals From View

@implementation DCAddTransactionPresenter (ViewInputs)

- (void)viewIsReady {
    self.transaction = [[DCTransaction alloc] init];
    self.transaction.date = [NSDate date];
    self.isAmountNegative = NO;
    [self.view setAmountGreen];
    [self.view setupCancelButtonWithText:[@"ADD_TRANSACTION_SCREEN.BUTTONS.CANCEL" localized]];
    [self.view setupOKButtonWithText:[@"ADD_TRANSACTION_SCREEN.BUTTONS.OK" localized]];
    [self.view setupAmountLabelTitle:[@"ADD_TRANSACTION_SCREEN.LABELS.AMOUNT" localized]];
    [self.view setupDateLabelTitle:[@"ADD_TRANSACTION_SCREEN.LABELS.DATE" localized]];
    [self.view setupDescriptionTitle:[@"ADD_TRANSACTION_SCREEN.LABELS.DESCRIPTION" localized]];
    
}

- (void)cancelButtonPressed {
    [self.view closePopover];
}

- (void)okButtonPressed {
    // Validating data
    if (self.isAmountNegative) {
        self.amount = [NSString stringWithFormat:@"-%@", self.amount];
    } else {
        self.amount = [NSString stringWithFormat:@"+%@", self.amount];
    }
    self.transaction.amount = [NSDecimalNumber decimalNumberWithString:self.amount];
    void (^responseCompletion)(DCTransactionValidationResponse *) = ^(DCTransactionValidationResponse *response) {
        if (response.isValid) {
            [self.view closePopoverWithTransaction:self.transaction];
        } else {
            if (response.isAmountValid) {
                [self.view setAmountValid];
            } else {
                [self.view setAmountError];
            }
            if (response.isDescriptionValid) {
                [self.view setDescriptionValid];
            } else {
                [self.view setDescriptionError];
            }
        }
    };
    [self.validator validateTransaction:self.transaction completion:(responseCompletion)];
}

- (void)amountChangedWithText:(NSString *)text {
    self.amount = text;
}

- (void)descriptionChangedText:(NSString *)text {
    self.transaction.transactionDescription = text;
}

- (void)plusMinusButtonPressed {
    if (self.isAmountNegative) {
        [self.view setAmountGreen];
        self.isAmountNegative = NO;
    } else {
        [self.view setAmountRed];
        self.isAmountNegative = YES;
    }
}

- (void)dateChanged:(NSDate *)date {
    self.transaction.date = date;
}

@end
