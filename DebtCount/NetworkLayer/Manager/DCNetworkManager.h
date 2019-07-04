//
//  DCNetworkManager.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 04/07/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCNetworkRouter.h"
#import "DCNetworkEnvironmentType.h"
#import "DCPerson.h"
#import "DCTransaction.h"
#import "DCPersonEndpoint.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCNetworkManager : NSObject

@property (class) DCNetworkEnvironmentType environment;

@property DCNetworkRouter *router;

- (void)getPersonsWithCompletion:(void(^)(NSArray *persons, NSString *error))completion;

- (void)getTransactionsForPersonId:(NSString *)personId
                        completion:(void(^)(NSArray *transactions, NSString *error))completion;

- (void)postPerson:(DCPerson *)person
        completion:(void(^)(void))completion;

- (void)postTransaction:(DCTransaction *)transaction
             completion:(void(^)(void))completion;

- (void)deletePersonById:(NSString *)personId
              completion:(void(^)(void))completion;

- (void)deleteTransactionForPersonId:(NSString *)personId
                   withTransactionId:(NSString *)transactionId
                          completion:(void(^)(void))completion;

@end

NS_ASSUME_NONNULL_END
