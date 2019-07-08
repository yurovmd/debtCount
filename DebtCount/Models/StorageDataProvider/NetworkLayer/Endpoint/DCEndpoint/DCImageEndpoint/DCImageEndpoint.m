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
    return @"/image";
}

- (DCHTTPMethodType)httpMethod {
    return DCHTTPMethodPost;
}

- (NSDictionary *)headers {
    return nil;
}

- (NSMutableDictionary *)bodyParameters {
    return nil;
}

- (NSData *)bodyData {
    NSData *imageData = UIImagePNGRepresentation(self.image);
    return imageData;
}

@end
