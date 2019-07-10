//
//  DCStorageDataProviderProtocol.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 05/07/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//
#import "DCPerson.h"
#import "DCTransaction.h"

@protocol DCStorageDataProviderProtocol

- (void)getPersonsWithCompletion:(void(^)(NSMutableArray *persons, NSString *error))completion;

- (void)getTransactionsForPersonId:(NSString *)personId
                        completion:(void(^)(NSMutableArray *transactions, NSString *error))completion;

- (void)postPerson:(DCPerson *)person
        completion:(void(^)(NSString *error))completion;

- (void)postTransaction:(DCTransaction *)transaction
            forPersonId:(NSString *)personId
             completion:(void(^)(NSString *error))completion;

- (void)deletePerson:(DCPerson *)person
              completion:(void(^)(NSString *error))completion;

- (void)deleteTransactionForPersonId:(NSString *)personId
                   withTransaction:(DCTransaction *)transaction
                          completion:(void(^)(void))completion;

- (void)postImage:(UIImage *)image
       completion:(void(^)(NSString *imageUrl, NSString *error))completion;

- (void)getImageWithURLString:(NSString *)imageURLString
                   completion:(void(^)(UIImage *image, NSString *error))completion;

@end
