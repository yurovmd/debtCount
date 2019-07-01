//
//  PersonDataController.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 24/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCPersonDataController.h"

@implementation DCPersonDataController

+ (id) shared {

    static DCPersonDataController *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;

}

- (id)init {
    self = [super init];
    if (!self) return nil;

    self.persistentContainer = [[NSPersistentContainer alloc] initWithName:@"DebtCount"];
    [self.persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *description, NSError *error) {
        if (error != nil) {
            NSLog(@"Failed to load Corein Data stack: %@", error);
            abort();
        }
    }];
    return self;
}

- (void)savePersonData:(DCPerson *)person completion:(void(^)(void))completion {

    [self.persistentContainer performBackgroundTask:^(NSManagedObjectContext * _Nonnull context) {
        NSError *error = nil;
        DCPersonMO *personManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"DCPersonMO" inManagedObjectContext:context];
        personManagedObject.name = person.name;
        personManagedObject.relation = person.relation;
        personManagedObject.avatarUrl = [self saveImageToFileManager:person.avatar];
        personManagedObject.debt = [NSDecimalNumber zero];
        personManagedObject.personId = person.personId;
        if ([context save:&error] == NO) {
            NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
        }
        completion();
    }];
}

- (NSString *)saveImageToFileManager:(UIImage *)image {
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSData *avatarData = UIImagePNGRepresentation(image);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd-MM-yyyy-HH-mm-ss";
#warning [NSDate date] is nicer initializer
    NSDate *currentDate = [[NSDate alloc] init];
    NSString *imageName = [[formatter stringFromDate:currentDate] stringByAppendingString:@".png"];
    NSString *imagePath = [basePath stringByAppendingPathComponent:imageName];
    [avatarData writeToFile:imagePath atomically:YES];
    return imagePath;
}

- (void)saveTransactionData:(DCTransaction *)transaction
                  forPerson:(DCPerson *)person
                  completion:(void(^)(void))completion {
    [self.persistentContainer performBackgroundTask:^(NSManagedObjectContext * _Nonnull context) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DCPersonMO"];
        NSError *error = nil;
        NSArray *results = [context executeFetchRequest:request error:&error];
        if (!results) {
            NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
            abort();
        }
        for (DCPersonMO *personMO in results) {
            if ([personMO.personId isEqualToString:person.personId]) {
                DCTransactionMO *transactionManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"DCTransactionMO" inManagedObjectContext:context];
                transactionManagedObject.date = transaction.date;
                transactionManagedObject.transactionDescription = transaction.transactionDescription;
                transactionManagedObject.amount = transaction.amount ;
                transactionManagedObject.person = personMO;
                [personMO addTransactionsObject:transactionManagedObject];
                personMO.debt = [personMO.debt decimalNumberByAdding:transaction.amount];
                if ([context save:&error] == NO) {
                    NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
                }
                completion();
            }
        };
    }];

}

- (void)fetchPersonsWithCompletion:(void (^)(NSMutableArray *persons))completion {

    [self.persistentContainer performBackgroundTask:^(NSManagedObjectContext * _Nonnull context) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DCPersonMO"];
        NSError *error = nil;
        NSArray *results = [context executeFetchRequest:request error:&error];
        if (!results) {
            NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
            abort();
        }
#warning Would be nicer to delegate this mapping work to some Fabric or something in order to separate business logic (both for DCPerson and DCTransaction). Swifty 'Convenience' type of init would also be suitable
        NSMutableArray *persons = [[NSMutableArray alloc] init];
        for (DCPersonMO *personMO in results) {
#warning 'init' missing in [DCPerson alloc] call
            DCPerson *person = [DCPerson alloc];
            person.name = personMO.name;
            person.relation = personMO.relation;
            person.avatar = [[UIImage alloc] initWithContentsOfFile:personMO.avatarUrl];
            person.debt = personMO.debt;
            person.personId = personMO.personId;
            NSSet *transactions = [[NSSet alloc] init];
            for (DCTransactionMO *transactionMO in personMO.transactions) {
                DCTransaction * transaction = [[DCTransaction alloc] init];
                transaction.date = transactionMO.date;
                transaction.transactionDescription = transactionMO.transactionDescription;
                transaction.amount = transactionMO.amount;
                transactions = [transactions setByAddingObject:transaction];
            }
            person.transactions = transactions;
            [persons addObject:person];
        }
        completion(persons);
    }];
}

@end
