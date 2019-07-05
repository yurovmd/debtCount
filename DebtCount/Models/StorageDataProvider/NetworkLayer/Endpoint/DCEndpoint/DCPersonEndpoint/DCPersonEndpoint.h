//
//  DCEndpoint.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 04/07/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCEndpointAbstraction.h"
#import "DCNetworkManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCPersonEndpoint : NSObject <DCEndpointAbstraction>

@property (nonatomic) NSURL *baseURL;
@property (nonatomic) NSString *path;
@property (nonatomic) DCHTTPMethodType httpMethod;
@property (nonatomic) NSDictionary *headers;
@property (nonatomic) DCNetworkTaskType taskType;

- (instancetype)initWithTaskType:(DCNetworkTaskType)taskType;

@end

NS_ASSUME_NONNULL_END
