//
//  DCNetworkManager.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 04/07/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCNetworkManager.h"

// MARK: - Private Section

@interface DCNetworkManager (Private)

- (NSString *)handleNetworkResponse:(NSHTTPURLResponse *)response;

@end

@implementation DCNetworkManager (Private)

- (NSString *)handleNetworkResponse:(NSHTTPURLResponse *)response {
    switch ([response statusCode]) {
        case 200 ... 299:
            return nil;
            break;
        case 401 ... 500:
            return @"You need to be authenticated first.";
            break;
        case 501 ... 599:
            return @"Bad request";
            break;
        case 600:
            return @"The url you requested is outdated.";
            break;
        default:
            return @"Network request failed.";
            break;
    }
}

@end

@implementation DCNetworkManager

static DCNetworkEnvironmentType defaultEnvironment = DCNetworkEnvironmentTypeDev;

+ (DCNetworkEnvironmentType)environment {
    return defaultEnvironment;
}

+ (void)setEnvironment:(DCNetworkEnvironmentType)environment {
    defaultEnvironment = environment;
}

- (instancetype) init {
    if (self = [super init]) {
        self.router = [[DCNetworkRouter alloc] init];
    }
    return self;
}

@end

// MARK: - DCStorageDataProviderProtocol

@implementation DCNetworkManager (DCStorageDataProviderProtocol)

- (void)getPersonsWithCompletion:(void(^)(NSMutableArray *persons, NSString *error))completion {
    DCPersonEndpoint *endpoint = [[DCPersonEndpoint alloc]
                                  initWithTaskType:DCNetworkTaskTypeRequest
                                  person:nil];
    void (^requestCompletion)(NSData *data,
                              NSURLResponse *response,
                              NSError *error) = ^(NSData *data,
                                                  NSURLResponse *response,
                                                  NSError *error) {
        if (error != nil) {
            completion(nil, @"Please check your network connection.");
        }
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSHTTPURLResponse *httpResponce = (NSHTTPURLResponse *)response;
            NSString *result = [self handleNetworkResponse:httpResponce];
            if (result != nil) {
                completion(nil, result);
                return;
            }
            if (data == nil) {
                completion(nil, @"Response returned with no data to decode.");
                return;
            }
            NSError *serializationError = nil;
            id apiResponse = [NSJSONSerialization
                              JSONObjectWithData:data
                              options:0
                              error:&serializationError];
            if (error) {
                completion(nil, @"We could not decode the response.");
            }
            NSMutableArray *persons = [[NSMutableArray alloc] init];
            if ([apiResponse isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dict in apiResponse) {
                    DCPerson *person = [[DCPerson alloc] initWithDictionary:dict];
                    [persons addObject:person];
                }
                completion(persons, nil);
            }
#warning If response is not a type of Array, where is completion?
        }
    };
    [self.router requestForEndpoint:endpoint completion:requestCompletion];
}

- (void)getTransactionsForPersonId:(NSString *)personId
                        completion:(void(^)(NSMutableArray *transactions, NSString *error))completion {
    DCTransactionEndpoint *endpoint = [[DCTransactionEndpoint alloc]
                                       initWithTaskType:DCNetworkTaskTypeRequest
                                       personId:(NSString *)personId
                                       transaction:nil];
    void (^requestCompletion)(NSData *data,
                              NSURLResponse *response,
                              NSError *error) = ^(NSData *data,
                                                  NSURLResponse *response,
                                                  NSError *error) {
        if (error != nil) {
            completion(nil, @"Please check your network connection.");
        }
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSHTTPURLResponse *httpResponce = (NSHTTPURLResponse *)response;
            NSString *result = [self handleNetworkResponse:httpResponce];
            if (result != nil) {
                completion(nil, result);
                return;
            }
            if (data == nil) {
                completion(nil, @"Response returned with no data to decode.");
                return;
            }
            NSError *serializationError = nil;
            id apiResponse = [NSJSONSerialization
                              JSONObjectWithData:data
                              options:0
                              error:&serializationError];
            if (error) {
                completion(nil, @"We could not decode the response.");
            }
            NSMutableArray *transactions = [[NSMutableArray alloc] init];
            if ([apiResponse isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dict in apiResponse) {
                    DCTransaction *transaction = [[DCTransaction alloc] initWithDictionary:dict];
                    [transactions addObject:transaction];
                }
                completion(transactions, nil);
            }
        }
#warning Missing completion for 'else' statement
    };
    [self.router requestForEndpoint:endpoint completion:requestCompletion];
}

- (void)postPerson:(DCPerson *)person
        completion:(void(^)(NSString *error))completion {
    DCPersonEndpoint *endpoint = [[DCPersonEndpoint alloc]
                                  initWithTaskType:DCNetworkTaskTypePOST
                                  person:person];
    void (^requestCompletion)(NSData *data,
                              NSURLResponse *response,
                              NSError *error) = ^(NSData *data,
                                                  NSURLResponse *response,
                                                  NSError *error) {
        if (data == nil) {
            completion(@"Response returned with no data to decode.");
            return;
        }
        id apiResponse = [NSJSONSerialization
                          JSONObjectWithData:data
                          options:0
                          error:NULL];
        
        if ([apiResponse isKindOfClass:[NSDictionary class]] && ([apiResponse objectForKey:@"error"] != nil)) {
            NSString *error = [[NSString alloc] initWithString:[apiResponse objectForKey:@"reason"]];
            if (error) {
                completion(error);
                return;
            }
        }
        completion(nil);
    };
    [self.router requestForEndpoint:endpoint completion:requestCompletion];
}

- (void)postTransaction:(DCTransaction *)transaction
            forPersonId:(NSString *)personId
             completion:(void(^)(NSString *error))completion {
    DCTransactionEndpoint *endpoint = [[DCTransactionEndpoint alloc]
                                       initWithTaskType:DCNetworkTaskTypePOST
                                       personId:(NSString *)personId
                                       transaction:transaction];
    void (^requestCompletion)(NSData *data,
                              NSURLResponse *response,
                              NSError *error) = ^(NSData *data,
                                                  NSURLResponse *response,
                                                  NSError *error) {
        if (data == nil) {
            completion(@"Response returned with no data to decode.");
            return;
        }
        id apiResponse = [NSJSONSerialization
                          JSONObjectWithData:data
                          options:0
                          error:NULL];
        if ([apiResponse isKindOfClass:[NSDictionary class]] && ([apiResponse objectForKey:@"error"] != nil)) {
            NSString *error = [[NSString alloc] initWithString:[apiResponse objectForKey:@"reason"]];
            if (error) {
                completion(error);
                return;
            }
        }
        completion(nil);
    };
    [self.router requestForEndpoint:endpoint completion:requestCompletion];
}

- (void)deletePerson:(DCPerson *)person
              completion:(void(^)(NSString *error))completion {
    DCPersonEndpoint *endpoint = [[DCPersonEndpoint alloc]
                                  initWithTaskType:DCNetworkTaskTypeDELETE
                                  person:person];
    void (^requestCompletion)(NSData *data,
                              NSURLResponse *response,
                              NSError *error) = ^(NSData *data,
                                                  NSURLResponse *response,
                                                  NSError *error) {
        if (error == nil) {
            completion(nil);
        } else {
            completion(@"Problem with person deletion");
        }
    };
    [self.router requestForEndpoint:endpoint completion:requestCompletion];
}

- (void)deleteTransactionForPersonId:(NSString *)personId
                     withTransaction:(DCTransaction *)transaction
                          completion:(void(^)(NSString *error))completion {
    DCTransactionEndpoint *endpoint = [[DCTransactionEndpoint alloc]
                                       initWithTaskType:DCNetworkTaskTypeDELETE
                                       personId:(NSString *)personId
                                       transaction:transaction];
    void (^requestCompletion)(NSData *data,
                              NSURLResponse *response,
                              NSError *error) = ^(NSData *data,
                                                  NSURLResponse *response,
                                                  NSError *error) {
        if (data == nil) {
            completion(@"Response returned with no data to decode.");
            return;
        }
        id apiResponse = [NSJSONSerialization
                          JSONObjectWithData:data
                          options:0
                          error:NULL];
        if ([apiResponse isKindOfClass:[NSDictionary class]] && ([apiResponse objectForKey:@"error"] != nil)) {
            NSString *error = [[NSString alloc] initWithString:[apiResponse objectForKey:@"reason"]];
            if (error) {
                completion(error);
                return;
            }
        }
        completion(nil);
    };
    [self.router requestForEndpoint:endpoint completion:requestCompletion];
}

- (void)postImage:(UIImage *)image
       completion:(void(^)(NSString *imageUrl, NSString *error))completion {
    DCImageEndpoint *endpoint = [[DCImageEndpoint alloc]
                                 initWithImage:image];
    void (^requestCompletion)(NSData *data,
                              NSURLResponse *response,
                              NSError *error) = ^(NSData *data,
                                                  NSURLResponse *response,
                                                  NSError *error) {
        if (error != nil) {
            completion(nil, @"Please check your network connection.");
        }
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSHTTPURLResponse *httpResponce = (NSHTTPURLResponse *)response;
            NSString *result = [self handleNetworkResponse:httpResponce];
            if (result != nil) {
                completion(nil, result);
                return;
            }
            if (data == nil) {
                completion(nil, @"Response returned with no data to decode.");
                return;
            }
            NSError *serializationError = nil;
            id apiResponse = [NSJSONSerialization
                              JSONObjectWithData:data
                              options:0
                              error:&serializationError];
            if (error) {
                completion(nil, @"We could not decode the response.");
            }
            if ([apiResponse isKindOfClass:[NSDictionary class]]) {
                completion(apiResponse[@"url"], nil);
            }
        }
#warning Missing 'default' completion
    };
    [self.router requestForEndpoint:endpoint completion:requestCompletion];
}

- (void)getImageWithURLString:(NSString *)imageURLString
                   completion:(void(^)(UIImage *image, NSString *error))completion {
    void (^requestCompletion)(NSData *data,
                              NSURLResponse *response,
                              NSError *error) = ^(NSData *data,
                                                  NSURLResponse *response,
                                                  NSError *error) {
        if (error != nil) {
            completion(nil, @"Please check your network connection.");
        }
        UIImage *image = [[UIImage alloc] initWithData:data];
        if (image != nil) {
            completion(image, nil);
        } else {
            completion(nil, @"problem with deserializing image data");
        }
    };
    [self.router requestImage:imageURLString completion:requestCompletion];
}

@end
