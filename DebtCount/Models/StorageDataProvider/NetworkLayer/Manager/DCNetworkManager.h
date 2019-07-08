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
#import "DCStorageDataProviderProtocol.h"
#import "DCImageEndpoint.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCNetworkManager : NSObject

@property (class) DCNetworkEnvironmentType environment;

@property DCNetworkRouter *router;

@end

// MARK: - DCStorageDataProviderProtocol

@interface DCNetworkManager (DCStorageDataProviderProtocol) <DCStorageDataProviderProtocol>

- (void)getPersonsWithCompletion:(void(^)(NSMutableArray *persons, NSString *error))completion;

- (void)getTransactionsForPersonId:(NSString *)personId
                        completion:(void(^)(NSMutableArray *transactions, NSString *error))completion;

- (void)postPerson:(DCPerson *)person
        completion:(void(^)(void))completion;

- (void)postTransaction:(DCTransaction *)transaction
            forPersonId:(NSString *)personId
             completion:(void(^)(void))completion;

- (void)deletePersonById:(NSString *)personId
              completion:(void(^)(void))completion;

- (void)deleteTransactionForPersonId:(NSString *)personId
                     withTransaction:(DCTransaction *)transaction
                          completion:(void(^)(void))completion;

- (void)postImage:(UIImage *)image
       completion:(void(^)(NSString *imageUrl, NSString *error))completion;

@end

NS_ASSUME_NONNULL_END
