//
//  DCImageEndpoint.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 08/07/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCImageEndpoint.h"

@interface DCImageEndpoint ()

@property (nonatomic) NSString *environmentURL;
@property UIImage *image;
@property (nonatomic) DCNetworkTaskType taskType;

@end

@implementation DCImageEndpoint

- (instancetype)initWithImage:(nullable UIImage *)image {
    if (self = [super init]) {
        self.image = image;
        self.taskType = DCNetworkTaskTypePOST;
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
    return @"/image";
}

- (DCHTTPMethodType)getHttpMethod {
    return DCHTTPMethodPost;
}

- (DCNetworkTaskType)getTaskType {
    return self.taskType;
}

- (NSDictionary *)getHeaders {
    return nil;
}

- (NSMutableDictionary *)getBodyParameters {
    return nil;
}

- (NSData *)getBodyData {
    NSData *imageData = UIImagePNGRepresentation(self.image);
    return imageData;
}

- (NSMutableDictionary *)getUrlParameters {
    return nil;
}

@end
