//
//  PersonsListPresenter.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 19/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCPersonsListPresenter.h"
#import "DCPersonsListViewController.h"
#import "DCAppStorageType.h"

// MARK: - Properties

@interface DCPersonsListPresenter ()

- (void)getPersonsAndFirstOpen:(BOOL)firstOpen;
- (void)configureStorageType:(DCAppStorageType)storageType;

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
    [self.view openDataSourceTypeAlert];
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
    [DCStorageDataProvider.shared.manager getPersonsWithCompletion:completion];
}

- (void)configureStorageType:(DCAppStorageType)storageType {
    [DCStorageDataProvider.shared configureWithStorageType:storageType];
}

- (void)userDeleleCellPressedAtIndexPath:(NSIndexPath *)indexPath {
    void (^completion)(NSString *error) = ^(NSString *error) {
        if (error == nil) {
            [self.persons removeObjectAtIndex:indexPath.row];
            [self.view removeCellAtIndexPath:indexPath];
        }
    };
    DCPerson *personToDelete = self.persons[indexPath.row];
    [DCStorageDataProvider.shared.manager deletePerson:personToDelete
                                            completion:completion];
}

- (void)userChoosedNetworkStoragetype {
    [self configureStorageType:DCAppStorageTypeRemote];
    [self getPersonsAndFirstOpen:YES];
}

- (void)userChoosedLocalStorageType {
    [self configureStorageType:DCAppStorageTypeLocal];
    [self getPersonsAndFirstOpen:YES];
}

@end
