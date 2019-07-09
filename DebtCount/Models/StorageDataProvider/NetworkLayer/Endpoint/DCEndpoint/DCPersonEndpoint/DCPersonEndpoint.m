//
//  DCEndpoint.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 04/07/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCPersonEndpoint.h"

@interface DCPersonEndpoint ()

@property (nonatomic) NSString *environmentURL;
@property DCPerson *person;

@end

@implementation DCPersonEndpoint

- (instancetype)initWithTaskType:(DCNetworkTaskType)taskType
                          person:(DCPerson *)person {
    if (self = [super init]) {
        self.taskType = taskType;
        self.person = person;
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
    return @"/people";
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
        case DCNetworkTaskTypePOST:
            [parameters setValue:self.person.name forKey:@"name"];
            [parameters setValue:self.person.relation forKey:@"relation"];
            [parameters setValue:self.person.avatarUrl forKey:@"avatar"];
            return parameters;
            break;
        case DCNetworkTaskTypeDELETE:
            return nil;
            break;
    }
}

- (NSData *)bodyData {
    return nil;
}

- (NSMutableDictionary *)urlParameters {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    switch (self.taskType) {
        case DCNetworkTaskTypeRequest:
            return nil;
            break;
        case DCNetworkTaskTypePOST:
            return nil;
            break;
        case DCNetworkTaskTypeDELETE:
            [parameters setValue:self.person.personId forKey:@"personId"];
            return parameters;
            break;
    }
}

@end
