//
//  DCNetworkManager.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 04/07/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCNetworkManager.h"

@implementation DCNetworkManager

static DCNetworkEnvironmentType defaultEnvironment = DCNetworkEnvironmentTypeDev;

+ (DCNetworkEnvironmentType)environment {
    return defaultEnvironment;
}

+ (void)setEnvironment:(DCNetworkEnvironmentType)environment {
    defaultEnvironment = environment;
}

- (instancetype) init {
    if (self = [super init]) {
    }
    return self;
}

- (void)getPersonsWithCompletion:(void(^)(NSArray *persons, NSString *error))completion {
    DCPersonEndpoint *endpoint = [[DCPersonEndpoint alloc] initWithTaskType:DCNetworkTaskTypeRequest];
    void (^requestCompletion)(NSData *data,
                              NSURLResponse *response,
                              NSError *error) = ^(NSData *data,
                                                 NSURLResponse *response,
                                                 NSError *error) {
        if (error != nil) {
            completion(nil, @"Please check your network connection.");
        }
        // TODO: -
    };
    [self.router requestForEndpoint:endpoint completion:requestCompletion];
}

- (void)getTransactionsForPersonId:(NSString *)personId
                        completion:(void(^)(NSArray *transactions, NSString *error))completion {

}

- (void)postPerson:(DCPerson *)person
        completion:(void(^)(void))completion {

}

- (void)postTransaction:(DCTransaction *)transaction
             completion:(void(^)(void))completion {

}

- (void)deletePersonById:(NSString *)personId
              completion:(void(^)(void))completion {

}

- (void)deleteTransactionForPersonId:(NSString *)personId
                   withTransactionId:(NSString *)transactionId
                          completion:(void(^)(void))completion {

}

@end
