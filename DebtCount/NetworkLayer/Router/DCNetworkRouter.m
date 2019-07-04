//
//  DCNetworkRouter.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 04/07/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCNetworkRouter.h"

@interface DCNetworkRouter ()

@property NSURLSessionTask *task;

- (NSURLRequest *)buildRequestFrom:(id)endpoint;

@end

@implementation DCNetworkRouter

- (void)requestForEndpoint:(id<DCEndpointAbstraction>)endpoint
                completion:(void (^)(NSData *data,
                                     NSURLResponse *response,
                                     NSError *error))completion {
    NSURLSession *session = NSURLSession.sharedSession;
    NSURLRequest *request = [self buildRequestFrom:endpoint];
    self.task = [session dataTaskWithRequest:request
                      completionHandler:completion];
    [self.task resume];
}

- (NSURLRequest *)buildRequestFrom:(id<DCEndpointAbstraction>)endpoint {

    NSMutableURLRequest *request =
    [[NSMutableURLRequest  alloc] initWithURL:[endpoint.baseURL URLByAppendingPathComponent:endpoint.path]
                                  cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                              timeoutInterval:10.0];

    switch (endpoint.taskType) {
        case DCNetworkTaskTypeRequest:
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        case DCNetworkTaskTypePOST:
            break;
        case DCNetworkTaskTypeDELETE:
            break;
    }

    return request;
    
}

- (void)cancel {
    [self.task cancel];
}

@end
