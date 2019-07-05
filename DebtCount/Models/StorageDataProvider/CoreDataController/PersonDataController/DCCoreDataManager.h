//
//  PersonDataController.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 24/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "DCTransactionMO+CoreDataClass.h"
#import "DCPersonMO+CoreDataClass.h"
#import "DCStorageDataProviderProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCCoreDataManager : NSObject

@property (strong, nonatomic) NSPersistentContainer *persistentContainer;

- (instancetype)init;

@end

// MARK: - DCStorageDataProviderProtocol

@interface DCCoreDataManager (DCStorageDataProviderProtocol) <DCStorageDataProviderProtocol>

@end

NS_ASSUME_NONNULL_END
