//
//  DCTransactionCell.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 27/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCTransaction.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCTransactionCell : UITableViewCell

@property DCTransaction *transaction;

@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

// MARK: - Cell Configuration After dequeue stage

@interface DCTransactionCell (Configuration)

- (void)configure:(DCTransaction *)transaction;

@end

// MARK: - Private Category

@interface DCTransactionCell (Private)

- (void)setupUI;

@end

// MARK: - Signals From Presenter

@interface DCTransactionCell (Presenter)

- (void)setAmountText:(NSString *)text;
- (void)setDescriptionText:(NSString *)text;
- (void)setDateText:(NSString *)text;
- (void)setAmountLabelColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
