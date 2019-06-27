//
//  DCPersonMO+CoreDataProperties.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 27/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//
//

#import "DCPersonMO+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface DCPersonMO (CoreDataProperties)

+ (NSFetchRequest<DCPersonMO *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSData *avatar;
@property (nullable, nonatomic, copy) NSDecimalNumber *debt;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *personId;
@property (nullable, nonatomic, copy) NSString *relation;
@property (nullable, nonatomic, retain) NSSet<DCTransactionMO *> *transactions;

@end

@interface DCPersonMO (CoreDataGeneratedAccessors)

- (void)addTransactionsObject:(DCTransactionMO *)value;
- (void)removeTransactionsObject:(DCTransactionMO *)value;
- (void)addTransactions:(NSSet<DCTransactionMO *> *)values;
- (void)removeTransactions:(NSSet<DCTransactionMO *> *)values;

@end

NS_ASSUME_NONNULL_END
