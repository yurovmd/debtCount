//
//  DCTransactionMO+CoreDataProperties.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 05/07/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//
//

#import "DCTransactionMO+CoreDataProperties.h"

@implementation DCTransactionMO (CoreDataProperties)

+ (NSFetchRequest<DCTransactionMO *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"DCTransactionMO"];
}

@dynamic amount;
@dynamic date;
@dynamic transactionDescription;
@dynamic person;

@end
