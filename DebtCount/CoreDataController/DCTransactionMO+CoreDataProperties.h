//
//  DCTransactionMO+CoreDataProperties.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 27/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//
//

#import "DCTransactionMO+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface DCTransactionMO (CoreDataProperties)

+ (NSFetchRequest<DCTransactionMO *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, copy) NSString *transactionDescription;
@property (nullable, nonatomic, copy) NSDecimalNumber *amount;
@property (nullable, nonatomic, retain) DCPersonMO *person;

@end

NS_ASSUME_NONNULL_END
