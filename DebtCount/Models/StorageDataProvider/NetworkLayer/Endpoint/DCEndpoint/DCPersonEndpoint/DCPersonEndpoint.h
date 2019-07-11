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
#import "DCPerson.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCPersonEndpoint : NSObject <DCEndpointAbstraction>

- (instancetype)initWithTaskType:(DCNetworkTaskType)taskType
                          person:(nullable DCPerson *)person;

@end

NS_ASSUME_NONNULL_END
