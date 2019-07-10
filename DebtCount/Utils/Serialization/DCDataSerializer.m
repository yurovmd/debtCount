//
//  DCDataSerializer.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 02/07/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCDataSerializer.h"
#import "DCFilesManager.h"

@implementation DCDataSerializer

+ (DCPersonMO *)getManagedObject:(DCPersonMO *)personManagedObject
                      fromPerson:(DCPerson *)person {
    personManagedObject.name = person.name;
    personManagedObject.relation = person.relation;
    personManagedObject.avatarUrl = person.avatarUrl;
    personManagedObject.debt = [NSDecimalNumber zero];
    personManagedObject.personId = person.personId;
    return personManagedObject;
}

+ (DCTransactionMO *)getManagedObject:(DCTransactionMO *)transactionManagedObject
                      fromTransaction:(DCTransaction *)transaction
              withPersonManagedObject:(DCPersonMO *)personMO {
    transactionManagedObject.date = transaction.date;
    transactionManagedObject.transactionDescription = transaction.transactionDescription;
    transactionManagedObject.amount = transaction.amount ;
    transactionManagedObject.person = personMO;
    [personMO addTransactionsObject:transactionManagedObject];
    personMO.debt = [personMO.debt decimalNumberByAdding:transaction.amount];
    return transactionManagedObject;
}

@end
