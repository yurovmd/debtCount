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
@property (nonatomic) DCNetworkTaskType taskType;

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
    return API_DEV;
}

- (NSURL *)getBaseURL {
    NSURL *url = [[NSURL alloc] initWithString:self.environmentURL];
    return url;
}

- (NSString *)getPath {
    switch (self.taskType) {
        case DCNetworkTaskTypeRequest: {
            return [NSString stringWithFormat:@"/people/%@/debts", self.personId];
        }
        case DCNetworkTaskTypePOST: {
            return [NSString stringWithFormat:@"/people/%@/debts", self.personId];
        }
        case DCNetworkTaskTypeDELETE: {
            return [NSString stringWithFormat:@"/people/%@/debts/%@", self.personId,
                    self.transaction.transactionId];
        }
    }
}

- (DCHTTPMethodType)getHttpMethod {
    switch (self.taskType) {
        case DCNetworkTaskTypeRequest: {
            return DCHTTPMethodGet;
        }
        case DCNetworkTaskTypePOST: {
            return DCHTTPMethodPost;
        }
        case DCNetworkTaskTypeDELETE: {
            return DCHTTPMethodDelete;
        }
    }
}

- (DCNetworkTaskType)getTaskType {
    return self.taskType;
}

- (NSDictionary *)getHeaders {
    return nil;
}

- (NSMutableDictionary *)getBodyParameters {
    switch (self.taskType) {
        case DCNetworkTaskTypeRequest: {
            return nil;
        }
        case DCNetworkTaskTypePOST: {
            NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
            parameters[@"description"] = self.transaction.transactionDescription;
            NSNumber *amount = @(self.transaction.amount.intValue);
            parameters[@"value"] = amount;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormatForStorage];
            NSString *iso8601String = [dateFormatter stringFromDate:self.transaction.date];
            parameters[@"date"] = iso8601String;
            return parameters;
        }
        case DCNetworkTaskTypeDELETE: {
            return nil;
        }
    }
}

- (NSData *)getBodyData {
    return nil;
}

- (NSMutableDictionary *)getUrlParameters {
    return nil;
}
@end
