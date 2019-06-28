//
//  DCAddTransactionPresenter.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 28/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCAddTransactionViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCAddTransactionPresenter : NSObject

- (instancetype)initWithView:(DCAddTransactionViewController *)view validator:(id<DCValidatorProtocol>)validator;

@end

// MARK: - Signals From View

@interface DCAddTransactionPresenter (ViewInputs)

- (void)viewIsReady;

- (void)cancelButtonPressed;
- (void)okButtonPressed;
- (void)amountChangedWithText:(NSString *)text;
- (void)descriptionChangedText:(NSString *)text;
- (void)plusMinusButtonPressed;
- (void)dateChanged:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
