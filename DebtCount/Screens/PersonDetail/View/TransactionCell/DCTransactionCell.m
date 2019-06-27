//
//  DCTransactionCell.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 27/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCTransactionCell.h"
#import "DCTransactionCellPresenter.h"

@interface DCTransactionCell ()

@property DCTransactionCellPresenter *presenter;

@end

@implementation DCTransactionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

@end

// MARK: - Cell Configuration After dequeue stage

@implementation DCTransactionCell (Configuration)

- (void)configure:(DCTransaction *)transaction {
    self.presenter = [[DCTransactionCellPresenter alloc] initWithViewCell:self forTransaction:self.transaction];
    [self.presenter viewIsReadyForData];
}

@end

// MARK: - Private Category

@implementation DCTransactionCell (Private)

- (void)setupUI {

}

@end

// MARK: - Signals From Presenter

@implementation DCTransactionCell (Presenter)

- (void)setAmountText:(NSString *)text {
    self.amountLabel.text = text;
}

- (void)setDescriptionText:(NSString *)text {
    self.descriptionLabel.text = text;
}

- (void)setDateText:(NSString *)text {
    self.dateLabel.text = text;
}

- (void)setAmountLabelColor:(UIColor *)color {
    self.amountLabel.textColor = color;
}

@end
