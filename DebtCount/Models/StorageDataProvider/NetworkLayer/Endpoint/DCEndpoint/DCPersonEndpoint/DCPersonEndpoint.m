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
@property (nonatomic) DCNetworkTaskType taskType;

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
    return API_DEV;
}

- (NSURL *)getBaseURL {
    NSURL *url = [[NSURL alloc] initWithString:self.environmentURL];
    return url;
}

- (NSString *)getPath {
    return @"/people";
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
            parameters[@"name"] = self.person.name;
            parameters[@"relation"] = self.person.relation;
            parameters[@"avatar"] = self.person.avatarUrl;
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
    switch (self.taskType) {
        case DCNetworkTaskTypeRequest: {
            return nil;
        }
        case DCNetworkTaskTypePOST: {
            return nil;
        }
        case DCNetworkTaskTypeDELETE: {
            NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
            parameters[@"personId"] = self.person.personId;
            return parameters;
        }
    }
}

@end
