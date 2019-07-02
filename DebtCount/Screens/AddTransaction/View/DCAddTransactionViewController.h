//
//  DCAddTransactionVIewController.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 28/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCAddTransactionDelegateProtocol.h"
#import "DCAddTextField.h"
#import "DCValidator.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCAddTransactionViewController : UIViewController

@property (weak) id<DCAddTransactionDelegateProtocol> delegate;

@property (nullable) UITextField *activeField;

@end

// MARK: - Signals From Presenter

@interface DCAddTransactionViewController (Presenter)

- (void)setDatePickerMaximumDate:(NSDate *)date;
- (void)setupCancelButtonWithText:(NSString *)text;
- (void)setupOKButtonWithText:(NSString *)text;
- (void)setupAmountLabelTitle:(NSString *)text;
- (void)setupDateLabelTitle:(NSString *)text;
- (void)setupDescriptionTitle:(NSString *)text;

- (void)setAmountError;

- (void)closePopover;
- (void)closePopoverWithTransaction:(DCTransaction *)transaction;

- (void)setAmountGreen;
- (void)setAmountRed;

@end

NS_ASSUME_NONNULL_END
