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
@property DCPerson *person;

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

- (void) saveTransaction:(DCTransaction *)transaction completion:(void(^)(void))completion {
    [DCPersonDataController.shared saveTransactionData:transaction
                                             forPerson:self.person
                                            completion:completion];
}

@end

// MARK: - Signals From View

@implementation DCPersonDetailsPresenter (ViewInputs)

- (void)viewIsReadyWithPerson:(DCPerson *)person {
    self.cellModels = [[NSMutableArray alloc] init];
    self.person = [[DCPerson alloc] init];
    self.person = person;
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
    void (^completion)(void) = ^(void) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.cellModels addObject:transaction];
            [self.view updateTableViewWithModels:self.cellModels];
            [self.view sendUpdateMessageToMasterController];
        });
    };
    [self saveTransaction:transaction completion:completion];

}

@end
