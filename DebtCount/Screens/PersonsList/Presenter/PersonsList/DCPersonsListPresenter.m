//
//  PersonsListPresenter.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 19/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCPersonsListPresenter.h"
#import "DCPersonsListViewController.h"

// MARK: - Properties

@interface DCPersonsListPresenter ()

- (void)getPersons;

@property (weak) DCPersonsListViewController *view;

@end

// MARK: - Implementation

@implementation DCPersonsListPresenter

- (instancetype)initWithView:(DCPersonsListViewController *)view {
    if (self = [super init]) {
        self.view = view;
    }
    return self;
}

- (void)viewIsReady {
    [self getPersons];
}

- (void)addPersonButtonPressed {
    [self.view showAddPersonPopover];
}

- (void)popoverClosedAndNeedReload {
    [self getPersons];
}

- (void)transactionAddedAndNeedReload {
    [self getPersons];
}

- (void)getPersons {
    void (^completion)(NSMutableArray *) = ^(NSMutableArray *persons) {
        self.persons = persons;
        [self.view reloadTableView];
        //[self.view openDetailsWithPerson:persons.firstObject];

    };
    [DCPersonDataController.shared fetchPersonsWithCompletion:(completion)];
}

@end
