//
//  DCDataDeserializer.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 02/07/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCDataDeserializer.h"

@implementation DCDataDeserializer

+ (DCPerson *)getPersonFromManagedObject:(DCPersonMO *)personManagedObject {
    DCPerson *person = [[DCPerson alloc] init];
    person.name = personManagedObject.name;
    person.relation = personManagedObject.relation;
    person.avatar = [[UIImage alloc] initWithContentsOfFile:personManagedObject.avatarUrl];
    person.debt = personManagedObject.debt;
    person.personId = personManagedObject.personId;
    NSSet *transactions = [[NSSet alloc] init];
    for (DCTransactionMO *transactionMO in personManagedObject.transactions) {
        DCTransaction * transaction = [[DCTransaction alloc] init];
        transaction.date = transactionMO.date;
        transaction.transactionDescription = transactionMO.transactionDescription;
        transaction.amount = transactionMO.amount;
        transactions = [transactions setByAddingObject:transaction];
    }
    person.transactions = transactions;
    return person;
}

@end
