//
//  DCEndpointAbstraction.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 04/07/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCNetworkTaskType.h"
#import "DCHTTPMethodType.h"

#define API_DEV @"https://apiakvelondebts-dev.vapor.cloud"
#define API_PROD @"https://apiakvelondebts-prod.vapor.cloud"

@protocol DCEndpointAbstraction

#warning Accessors (functions)
@property (nonatomic) NSURL *baseURL;
@property (nonatomic) NSString *path;
@property (nonatomic) DCHTTPMethodType httpMethod;
@property (nonatomic) NSDictionary *headers;
@property (nonatomic) DCNetworkTaskType taskType;
@property (nonatomic) NSMutableDictionary *bodyParameters;
@property (nonatomic) NSData *bodyData;
@property (nonatomic) NSMutableDictionary *urlParameters;

@end
