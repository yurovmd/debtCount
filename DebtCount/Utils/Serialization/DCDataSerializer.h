//
//  DCDataSerializer.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 02/07/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCPersonMO+CoreDataClass.h"
#import "DCTransactionMO+CoreDataClass.h"
#import "DCPerson.h"
#import "DCTransaction.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCDataSerializer : NSObject

+ (DCPersonMO *)getManagedObject:(DCPersonMO *)personManagedObject
                        fromPerson:(DCPerson *)person;

+ (DCTransactionMO *)getManagedObject:(DCTransactionMO *)transactionManagedObject
                      fromTransaction:(DCTransaction *)transaction
              withPersonManagedObject:(DCPersonMO *)personMO;

@end

NS_ASSUME_NONNULL_END
