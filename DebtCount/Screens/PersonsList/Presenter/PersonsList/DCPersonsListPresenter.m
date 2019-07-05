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

@property DCNetworkManager *networkManager;

- (void)getPersonsAndFirstOpen:(BOOL)firstOpen;

@property (weak) DCPersonsListViewController *view;

@end

// MARK: - Implementation

@implementation DCPersonsListPresenter

- (instancetype)initWithView:(DCPersonsListViewController *)view
              networkManager:(DCNetworkManager *)networkManager {
    if (self = [super init]) {
        self.view = view;
        self.networkManager = networkManager;
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
    void (^completion)(NSMutableArray *, NSString *) = ^(NSMutableArray *persons, NSString *error) { };
    if (firstOpen && ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )) {
        completion = ^(NSMutableArray *persons, NSString *error) {
            self.persons = persons;
            [self.view reloadTableView];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.view openDetailsWithPerson:persons.firstObject];
            });
        };
    } else {
        completion = ^(NSMutableArray *persons, NSString *error) {
            self.persons = persons;
            [self.view reloadTableView];
        };
    }
    [self.networkManager getPersonsWithCompletion:completion];
    //[DCPersonDataController.shared fetchPersonsWithCompletion:(completion)];
}

- (void)userDeleleCellPressedAtIndexPath:(NSIndexPath *)indexPath {
    void (^completion)(void) = ^(void) {
        [self.persons removeObjectAtIndex:indexPath.row];
        [self.view removeCellAtIndexPath:indexPath];
    };
    [DCPersonDataController.shared deletePerson:self.persons[indexPath.row] completion:completion];
}

@end
