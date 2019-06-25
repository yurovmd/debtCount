//
//  PersonCell.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 19/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCPersonCell.h"

@interface DCPersonCell ()

- (void)setupUI;

@end

@implementation DCPersonCell

@synthesize person = _person;

- (void)setPerson:(DCPerson *)person {
    _person = person;
    self.avatarImageView.image = person.avatar;
    self.relationsLabel.text = person.relation;
    self.nameLabel.text = person.name;
    self.debtLabel.text = person.debt.stringValue;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI {
    [self.avatarImageView.layer setCornerRadius:(self.avatarImageView.bounds.size.height / 2)];
    [self.avatarImageView.layer setMasksToBounds:true];
}

@end
