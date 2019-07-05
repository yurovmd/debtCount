//
//  DCNetworkManager.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 04/07/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCNetworkManager.h"

// MARK: - Private Section

@interface DCNetworkManager (Private)

- (NSString *)handleNetworkResponse:(NSHTTPURLResponse *)response;

@end

@implementation DCNetworkManager (Private)

- (NSString *)handleNetworkResponse:(NSHTTPURLResponse *)response {
    switch ([response statusCode]) {
        case 200 ... 299:
            return nil;
            break;
        case 401 ... 500:
            return @"You need to be authenticated first.";
            break;
        case 501 ... 599:
            return @"Bad request";
            break;
        case 600:
            return @"The url you requested is outdated.";
            break;
        default:
            return @"Network request failed.";
            break;
    }
}

@end

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
        self.router = [[DCNetworkRouter alloc] init];
    }
    return self;
}

- (void)getPersonsWithCompletion:(void(^)(NSMutableArray *persons, NSString *error))completion {
    DCPersonEndpoint *endpoint = [[DCPersonEndpoint alloc] initWithTaskType:DCNetworkTaskTypeRequest];
    void (^requestCompletion)(NSData *data,
                              NSURLResponse *response,
                              NSError *error) = ^(NSData *data,
                                                 NSURLResponse *response,
                                                 NSError *error) {
        if (error != nil) {
            completion(nil, @"Please check your network connection.");
        }
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSHTTPURLResponse *httpResponce = (NSHTTPURLResponse *)response;
            NSString *result = [self handleNetworkResponse:httpResponce];
            if (result != nil) {
                completion(nil, result);
                return;
            }
            if (data == nil) {
                completion(nil, @"Response returned with no data to decode.");
                return;
            }
            NSError *serializationError = nil;
            id apiResponse = [NSJSONSerialization
                                JSONObjectWithData:data
                                options:0
                                error:&serializationError];
            if (error) {
                completion(nil, @"We could not decode the response.");
            }
            NSMutableArray *persons = [[NSMutableArray alloc] init];
            if ([apiResponse isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dict in apiResponse) {
                    DCPerson *person = [[DCPerson alloc] initWithDictionary:dict];
                    [persons addObject:person];
                }
                completion(persons, nil);
            }
        }
    };
    [self.router requestForEndpoint:endpoint completion:requestCompletion];
}

- (void)getTransactionsForPersonId:(NSString *)personId
                        completion:(void(^)(NSMutableArray *transactions, NSString *error))completion {

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
