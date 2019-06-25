//
//  DCPersonCellPresenter.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 25/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCPersonCellPresenter.h"

@interface DCPersonCellPresenter ()

@property DCPerson *person;
@property (weak) DCPersonCell *cellView;
@property NSString *name;
@property NSString *relation;
@property NSString *debt;
@property UIImage *avatar;

@end

@implementation DCPersonCellPresenter

- (instancetype)initWithView:(DCPersonCell *)cellView {
    if (self = [super init]) {
        self.cellView = cellView;
    }
    return self;
}

- (void)viewIsReadyForPerson:(DCPerson *)person {
    self.person = person;
    [self.cellView setNameValue:[self getName]];
    [self.cellView setRelationValue:[self getRelation]];
    [self.cellView setDebtValue:[self getDebt]];
    [self.cellView setAvatarValue:[self getAvatar]];

    if (self.person.debt >=0) {
        [self.cellView setDebtGreen];
    } else {
        [self.cellView setDebtRed];
    }
}

@end

// MARK: - Data Provider

@implementation DCPersonCellPresenter (DataProvider)

- (NSString *)getName {
    return self.person.name;
}

- (NSString *)getRelation {
    return self.person.relation;
}

- (NSString *)getDebt {
    return [DCDebtFormatter string:self.person.debt];
}

- (UIImage *)getAvatar {
    return self.person.avatar;
}

@end