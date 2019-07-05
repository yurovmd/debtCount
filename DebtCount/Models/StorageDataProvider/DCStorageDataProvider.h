//
//  DCStorageDataProvider.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 05/07/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCStorageDataProviderProtocol.h"
#import "DCAppStorageType.h"
#import "DCCoreDataManager.h"
#import "DCNetworkManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCStorageDataProvider : NSObject

+ (DCStorageDataProvider *)shared;
- (id)init;

@property id<DCStorageDataProviderProtocol> manager;

- (void)configureWithStorageType:(DCAppStorageType)storageType;

@end

NS_ASSUME_NONNULL_END
