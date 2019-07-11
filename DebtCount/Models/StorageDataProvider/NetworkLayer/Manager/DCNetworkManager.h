//
//  DCNetworkManager.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 04/07/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCNetworkRouter.h"
#import "DCNetworkEnvironmentType.h"
#import "DCPerson.h"
#import "DCTransaction.h"
#import "DCPersonEndpoint.h"
#import "DCTransactionEndpoint.h"
#import "DCStorageDataProviderProtocol.h"
#import "DCImageEndpoint.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCNetworkManager : NSObject

#warning Remove it to macros
@property (class) DCNetworkEnvironmentType environment;

#warning move to .m file
@property DCNetworkRouter *router;

@end

// MARK: - DCStorageDataProviderProtocol

@interface DCNetworkManager (DCStorageDataProviderProtocol) <DCStorageDataProviderProtocol>

@end

NS_ASSUME_NONNULL_END
