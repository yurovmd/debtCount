//
//  DCTransactionCellPresenter.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 27/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCTransactionCell.h"
#import "DCDebtFormatter.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCTransactionCellPresenter : NSObject

- (instancetype)initWithViewCell:(DCTransactionCell *)cellView forTransaction:(DCTransaction *)transaction;

@property (weak) DCTransactionCell *cellView;

@end

// MARK: - Signals From View

@interface DCTransactionCellPresenter (ViewInputs)

- (void)viewIsReadyForData;

@end

// MARK: - Data Provider

@interface DCTransactionCellPresenter (DataProvider)

- (NSString *)getAmount;
- (NSString *)getDescription;
- (NSString *)getDate;

@end

NS_ASSUME_NONNULL_END
