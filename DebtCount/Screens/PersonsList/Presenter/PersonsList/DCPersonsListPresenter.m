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

- (void)getPersonsAndFirstOpen:(BOOL)firstOpen;

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
    [self getPersonsAndFirstOpen:YES];

}

- (void)addPersonButtonPressed {
    [self.view showAddPersonPopover];
}

- (void)popoverClosedAndNeedReload {
    [self getPersonsAndFirstOpen:NO];
}

- (void)transactionAddedAndNeedReload {
    [self getPersonsAndFirstOpen:NO];
}

- (void)getPersonsAndFirstOpen:(BOOL)firstOpen {
    void (^completion)(NSMutableArray *) = ^(NSMutableArray *persons) { };
    if (firstOpen && ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )) {
        completion = ^(NSMutableArray *persons) {
            self.persons = persons;
            [self.view reloadTableView];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.view openDetailsWithPerson:persons.firstObject];
            });
        };
    } else {
        completion = ^(NSMutableArray *persons) {
            self.persons = persons;
            [self.view reloadTableView];
        };
    }
    [DCPersonDataController.shared fetchPersonsWithCompletion:(completion)];
}

@end
