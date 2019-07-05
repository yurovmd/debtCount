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

@end

@implementation DCPersonEndpoint

- (instancetype)initWithTaskType:(DCNetworkTaskType)taskType {
    if (self = [super init]) {
        self.taskType = taskType;
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
    return DCHTTPMethodGet;
}

- (NSDictionary *)headers {
    return nil;
}

@end
