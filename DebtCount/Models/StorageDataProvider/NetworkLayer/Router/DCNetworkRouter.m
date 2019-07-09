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

- (NSURLRequest *)buildRequestFrom:(id<DCEndpointAbstraction>)endpoint;
- (NSMutableURLRequest *)configureParametersForRequest:(NSMutableURLRequest *)request
                                 withBodyParameters:(NSMutableDictionary *)parameters;
- (NSMutableURLRequest *)configureParametersForRequest:(NSMutableURLRequest *)request
                                    withURLParameters:(NSMutableDictionary *)parameters;
- (NSMutableURLRequest *)configureBodyOfRequest:(NSMutableURLRequest *)request
                                       withData:(NSData *)data;

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

    switch (endpoint.httpMethod) {
        case DCHTTPMethodGet:
            request.HTTPMethod = @"GET";
            break;
        case DCHTTPMethodPost:
            request.HTTPMethod = @"POST";
            break;
        case DCHTTPMethodDelete:
            request.HTTPMethod = @"DELETE";
            break;
    }

    switch (endpoint.taskType) {
        case DCNetworkTaskTypeRequest:
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            break;
        case DCNetworkTaskTypePOST:
            if (endpoint.bodyParameters != nil) {
                request = [self configureParametersForRequest:request
                                               withBodyParameters:endpoint.bodyParameters];
            } else if (endpoint.bodyData != nil) {
                request = [self configureBodyOfRequest:request
                                              withData:endpoint.bodyData];
            }
            break;
        case DCNetworkTaskTypeDELETE:
            request = [self configureParametersForRequest:request
                                        withURLParameters:endpoint.urlParameters];
            break;
    }

    return request;
    
}

- (void)requestImage:(NSString *)imageStringUrl
          completion:(void (^)(NSData *data,
                               NSURLResponse *response,
                               NSError *error))completion {
    NSURLSession *session = NSURLSession.sharedSession;
    NSURL *imageUrl = [[NSURL alloc] initWithString:imageStringUrl];
    NSURLSessionTask *imageDownloadTask = [session dataTaskWithURL:imageUrl completionHandler:completion];
    [imageDownloadTask resume];
}

- (NSMutableURLRequest *)configureParametersForRequest:(NSMutableURLRequest *)request
                                        withBodyParameters:(NSMutableDictionary *)parameters {
    NSError *error = nil;
    id jsonData = [NSJSONSerialization
                   dataWithJSONObject:parameters
                   options:NSJSONWritingPrettyPrinted
                   error:&error];
    request.HTTPBody = jsonData;

    if ([request valueForHTTPHeaderField:@"Content-Type"] == nil) {
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    
    return request;
}

- (NSMutableURLRequest *)configureParametersForRequest:(NSMutableURLRequest *)request
                                     withURLParameters:(NSMutableDictionary *)parameters {
    NSString *requestURLString = request.URL.absoluteString;
    NSString *appendingPart = [NSString stringWithFormat:@"/%@", [parameters valueForKey:@"personId"]];
    NSString *resultRequestURLString = [requestURLString stringByAppendingString:appendingPart];
    request.URL = [[NSURL alloc] initWithString:resultRequestURLString];
    if ([request valueForHTTPHeaderField:@"Content-Type"] == nil) {
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    }
    return request;
}

- (NSMutableURLRequest *)configureBodyOfRequest:(NSMutableURLRequest *)request
                                       withData:(NSData *)data {
    request.HTTPBody = data;
    
    if ([request valueForHTTPHeaderField:@"Content-Type"] == nil) {
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }

    return request;
}

- (void)cancel {
    [self.task cancel];
}

@end
