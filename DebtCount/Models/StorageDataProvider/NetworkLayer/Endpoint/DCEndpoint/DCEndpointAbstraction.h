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

@protocol DCEndpointAbstraction

@property (nonatomic) NSURL *baseURL;
@property (nonatomic) NSString *path;
@property (nonatomic) DCHTTPMethodType httpMethod;
@property (nonatomic) NSDictionary *headers;
@property (nonatomic) DCNetworkTaskType taskType;
@property (nonatomic) NSMutableDictionary *bodyParameters;
@property (nonatomic) NSData *bodyData;
@property (nonatomic) NSMutableDictionary *urlParameters;

@end
