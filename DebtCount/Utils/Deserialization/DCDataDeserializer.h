//
//  DCDataDeserializer.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 02/07/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCPerson.h"
#import "DCTransaction.h"
#import "DCPersonMO+CoreDataClass.h"
#import "DCTransactionMO+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCDataDeserializer : NSObject

+ (DCPerson *)getPersonFromManagedObject:(DCPersonMO *)personManagedObject;

@end

NS_ASSUME_NONNULL_END
