//
//  DCTransactionEndpoint.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 09/07/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCTransactionEndpoint.h"

@interface DCTransactionEndpoint ()

@property (nonatomic) NSString *environmentURL;
@property DCTransaction *transaction;
@property NSString *personId;

@end

@implementation DCTransactionEndpoint

- (instancetype)initWithTaskType:(DCNetworkTaskType)taskType
                        personId:(NSString *)personId
                     transaction:(DCTransaction *)transaction {
    if (self = [super init]) {
        self.taskType = taskType;
        self.personId = personId;
        self.transaction = transaction;
    }
    return self;
}

- (NSString *)environmentURL {
    switch (DCNetworkManager.environment) {
        case DCNetworkEnvironmentTypeProd:
            return @"https://apiakvelondebts-prod.vapor.cloud";
            break;
        case DCNetworkEnvironmentTypeDev:
            return @"https://apiakvelondebts-dev.vapor.cloud";
            break;
    }
}

- (NSURL *)baseURL {
    NSURL *url = [[NSURL alloc] initWithString:self.environmentURL];
    return url;
}

- (NSString *)path {
    switch (self.taskType) {
        case DCNetworkTaskTypeRequest:
            return [NSString stringWithFormat:@"/people/%@/debts", self.personId];
            break;
        case DCNetworkTaskTypePOST:
            return [NSString stringWithFormat:@"/people/%@/debts", self.personId];
            break;
        case DCNetworkTaskTypeDELETE:
            return [NSString stringWithFormat:@"/people/%@/debts/%@", self.personId, self.transaction.transactionId];
            break;
    }
}

- (DCHTTPMethodType)httpMethod {
    switch (self.taskType) {
        case DCNetworkTaskTypeRequest:
            return DCHTTPMethodGet;
            break;
        case DCNetworkTaskTypePOST:
            return DCHTTPMethodPost;
            break;
        case DCNetworkTaskTypeDELETE:
            return DCHTTPMethodDelete;
            break;
    }
}

- (NSDictionary *)headers {
    return nil;
}

- (NSMutableDictionary *)bodyParameters {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    switch (self.taskType) {
        case DCNetworkTaskTypeRequest:
            return nil;
            break;
        case DCNetworkTaskTypePOST: {
            [parameters setValue:self.transaction.transactionDescription forKey:@"description"];
            NSNumber *amount = @(self.transaction.amount.intValue);
            [parameters setValue:amount forKey:@"value"];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormatForStorage];
            NSString *iso8601String = [dateFormatter stringFromDate:self.transaction.date];
            [parameters setValue:iso8601String forKey:@"date"];
            return parameters;
            break;
        }
        case DCNetworkTaskTypeDELETE:
            return nil;
            break;
    }
}

- (NSData *)bodyData {
    return nil;
}

- (NSMutableDictionary *)urlParameters {
    return nil;
//    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
//    switch (self.taskType) {
//        case DCNetworkTaskTypeRequest:
//            return nil;
//            break;
//        case DCNetworkTaskTypePOST:
//            return nil;
//            break;
//        case DCNetworkTaskTypeDELETE:
//            [parameters setValue:self.transaction.transactionId forKey:@"debtId"];
//            return parameters;
//            break;
//    }
}
@end
