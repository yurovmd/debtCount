//
//  DCTransactionCellPresenter.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 27/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCTransactionCellPresenter.h"

@interface DCTransactionCellPresenter ()

@property DCTransaction *transaction;

@end

@implementation DCTransactionCellPresenter

- (instancetype)initWithViewCell:(DCTransactionCell *)cellView forTransaction:(DCTransaction *)transaction{
    if (self = [super init]) {
        self.cellView = cellView;
        self.transaction = transaction;
    }
    return self;
}

@end

// MARK: - Signals From View

@implementation DCTransactionCellPresenter (ViewSignals)

- (void)viewIsReadyForData {
    [self.cellView setAmountText:self.getAmount];
    [self.cellView setDescriptionText:self.getDescription];
    [self.cellView setDateText:self.getDate];

    if (self.transaction.amount >= 0) {
        [self.cellView setAmountLabelColor:UIColor.greenColor];
    } else {
        [self.cellView setAmountLabelColor:UIColor.redColor];
    }
}

@end

// MARK: - Data Provider

@implementation DCTransactionCellPresenter (DataProvider)

- (NSString *)getAmount {
    NSString *amountStringNumber = [DCDebtFormatter string:self.transaction.amount];
    NSString *localizedAmount =  [NSString stringWithFormat:[@"PERSON_DETAILS.CELL.AMOUNT" localized], amountStringNumber];
    return localizedAmount;
}

- (NSString *)getDescription {
    return self.transaction.transactionDescription;
}

- (NSString *)getDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd.MM.YYYY";
    return [formatter stringFromDate:self.transaction.date];
}

@end
