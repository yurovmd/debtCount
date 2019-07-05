//
//  DCNetworkRouter.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 04/07/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCEndpointAbstraction.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCNetworkRouter<Endpoint: id<DCEndpointAbstraction>> : NSObject

- (void)requestForEndpoint:(id<DCEndpointAbstraction>)endpoint
                completion:(void (^)(NSData *data,
                                     NSURLResponse *response,
                                     NSError *error))completion;
- (void)cancel;

@end

NS_ASSUME_NONNULL_END
