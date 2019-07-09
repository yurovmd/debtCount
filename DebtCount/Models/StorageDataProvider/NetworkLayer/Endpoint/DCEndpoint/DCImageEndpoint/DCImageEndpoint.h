//
//  DCImageEndpoint.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 08/07/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCEndpointAbstraction.h"
#import "DCNetworkManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCImageEndpoint : NSObject <DCEndpointAbstraction>

@property (nonatomic) NSURL *baseURL;
@property (nonatomic) NSString *path;
@property (nonatomic) DCHTTPMethodType httpMethod;
@property (nonatomic) NSDictionary *headers;
@property (nonatomic) DCNetworkTaskType taskType;
@property (nonatomic) NSMutableDictionary *bodyParameters;
@property (nonatomic) NSData *bodyData;
@property (nonatomic) NSMutableDictionary *urlParameters;

- (instancetype)initWithImage:(nullable UIImage *)image;

@end

NS_ASSUME_NONNULL_END
