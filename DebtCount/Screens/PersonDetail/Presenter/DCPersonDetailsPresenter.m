//
//  DCPersonDetailsPresenter.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 27/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCPersonDetailsPresenter.h"

@interface DCPersonDetailsPresenter ()

@property DCPerson *person;

- (void)fetchTransactions;

@end

@implementation DCPersonDetailsPresenter

- (instancetype)initWithView:(DCPersonDetailViewController *)view {
    if (self = [super init]) {
        self.view = view;
    }
    return self;
}

- (void)fetchTransactions {
    void (^completion)(NSMutableArray *, NSString *) = ^(NSMutableArray *transactions, NSString *error) {
        [self.cellModels removeAllObjects];
        for (DCTransaction *transaction in transactions) {
            [self.cellModels addObject: transaction];
        }
        [self.view updateTableView];
    };
    [DCStorageDataProvider.shared.manager getTransactionsForPersonId:self.person.personId
                                                          completion:completion];
}

@end

// MARK: - Private Category

@implementation DCPersonDetailsPresenter (Private)

- (void) saveTransaction:(DCTransaction *)transaction completion:(void(^)(NSString *))completion {
    [DCStorageDataProvider.shared.manager postTransaction:transaction
                                              forPersonId:self.person.personId
                                               completion:completion];
}

@end

// MARK: - Signals From View

@implementation DCPersonDetailsPresenter (ViewInputs)

- (void)viewIsReadyWithPerson:(DCPerson *)person {
    self.cellModels = [[NSMutableArray alloc] init];
    self.person = [[DCPerson alloc] init];
    self.person = person;
    [self fetchTransactions];
    [self.view setTitleViewTitle:person.name];
    // More to come when we will use chart
}

- (void)addButtonTapped {
    [self.view openTransactionPopover];
}

- (void)addedTransaction:(DCTransaction *)transaction {
    void (^completion)(NSString *error) = ^(NSString *error) {
        if (error) {

        } else {
            [self fetchTransactions];
            [self.view sendUpdateMessageToMasterController];
        }
    };
    [self saveTransaction:transaction completion:completion];

}

- (void)userDeleleCellPressedAtIndexPath:(NSIndexPath *)indexPath {
    void (^completion)(NSString *error) = ^(NSString *error) {
        if (error) {

        } else {
            [self.cellModels removeObjectAtIndex:indexPath.row];
            [self.view removeCellAtIndexPath:indexPath];
            [self.view sendUpdateMessageToMasterController];
        }
    };
    [DCStorageDataProvider.shared.manager deleteTransactionForPersonId:self.person.personId
                                                       withTransaction:self.cellModels[indexPath.row]
                                                            completion:completion];
}

- (void)userPulledRefresh {
    [self fetchTransactions];
}

@end
