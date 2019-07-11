//
//  DCTransactionEndpoint.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 09/07/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCEndpointAbstraction.h"
#import "DCNetworkManager.h"
#import "DCTransaction.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCTransactionEndpoint : NSObject <DCEndpointAbstraction>

- (instancetype)initWithTaskType:(DCNetworkTaskType)taskType
                        personId:(NSString *)personId
                     transaction:(nullable DCTransaction *)transaction;

@end

NS_ASSUME_NONNULL_END
