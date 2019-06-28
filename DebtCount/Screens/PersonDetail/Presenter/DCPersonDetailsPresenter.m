//
//  DCPersonDetailsPresenter.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 27/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCPersonDetailsPresenter.h"

@interface DCPersonDetailsPresenter ()

@property NSMutableArray *cellModels;

@end

@implementation DCPersonDetailsPresenter

- (instancetype)initWithView:(DCPersonDetailViewController *)view {
    if (self = [super init]) {
        self.view = view;
    }
    return self;
}

@end

// MARK: - Private Category

@implementation DCPersonDetailsPresenter (Private)

@end

// MARK: - Signals From View

@implementation DCPersonDetailsPresenter (ViewInputs)

- (void) viewIsReady {
    self.cellModels = [[NSMutableArray alloc] init];
}

- (void)personChanged:(DCPerson *)person {
    for (DCTransaction *transaction in person.transactions) {
        [self.cellModels addObject: transaction];
    }
    [self.view updateTableViewWithModels:self.cellModels];
    [self.view setTitleViewTitle:person.name];
    // More to come when we will use chart
}

- (void)addButtonTapped {
    [self.view openTransactionPopover];
}

- (void)addedTransaction:(DCTransaction *)transaction {
    [self.cellModels addObject:transaction];
    [self.view updateTableViewWithModels:self.cellModels];
}

@end
