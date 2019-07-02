//
//  PersonCell.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 19/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCPersonCell.h"
#import "DCPersonCellPresenter.h"

@interface DCPersonCell ()

@property DCPersonCellPresenter *presenter;

- (void)setupUI;

@end

@implementation DCPersonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
    self.presenter = [[DCPersonCellPresenter alloc] initWithView:self];
}

- (void)setupUI {
    self.backgroundColor = UIColor.iceBlue;
    self.nameLabel.textColor = UIColor.darkViolet;
    self.relationsLabel.textColor = UIColor.darkViolet;
    [self.avatarImageView.layer applyCornersValue:(self.avatarImageView.bounds.size.height / 2)];
}

@end

// MARK: - SignalsFromPresenter

@implementation DCPersonCell (SignalsFromPresenter)

- (void)setAvatarValue:(UIImage *)avatar {
    self.avatarImageView.image = avatar;
}

- (void)setNameValue:(NSString *)name {
    self.nameLabel.text = name;
}

- (void)setRelationValue:(NSString *)relation {
    self.relationsLabel.text = relation;
}

- (void)setDebtValue:(NSString *)debt {
    self.debtLabel.text = debt;
}

- (void)setDebtGreen {
    self.debtLabel.textColor = UIColor.lightCyan;
}

- (void)setDebtRed {
    self.debtLabel.textColor = UIColor.fancyRed;
}

@end

// MARK: - Cell Configuration After dequeue stage

@implementation DCPersonCell (Configuration)

- (void)configure:(DCPerson *)person {
    [self.presenter viewIsReadyForPerson:person];
}

@end
