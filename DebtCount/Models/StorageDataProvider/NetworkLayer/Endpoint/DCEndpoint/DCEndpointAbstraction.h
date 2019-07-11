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

- (NSURL *)getBaseURL;
- (NSString *)getPath;
- (DCHTTPMethodType)getHttpMethod;
- (DCNetworkTaskType)getTaskType;
- (NSDictionary *)getHeaders;
- (NSMutableDictionary *)getBodyParameters;
- (NSData *)getBodyData;
- (NSMutableDictionary *)getUrlParameters;

@end
