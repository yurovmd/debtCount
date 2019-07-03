//
//  PersonDataController.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 24/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCPersonDataController.h"
#import "DCDataSerializer.h"
#import "DCDataDeserializer.h"

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
        personManagedObject = [DCDataSerializer getManagedObject:personManagedObject
                                                      fromPerson:person];
        if ([context save:&error] == NO) {
            NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
        }
        completion();
    }];
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
                transactionManagedObject = [DCDataSerializer getManagedObject:transactionManagedObject
                                                              fromTransaction:transaction
                                                      withPersonManagedObject:personMO];
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
        NSMutableArray *persons = [[NSMutableArray alloc] init];
        for (DCPersonMO *personMO in results) {
            [persons addObject:[DCDataDeserializer getPersonFromManagedObject:personMO]];
        }
        completion(persons);
    }];
}

- (void)deletePerson:(DCPerson *)person completion:(void(^)(void))completion {

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
                [context deleteObject:personMO];
                if ([context save:&error] == NO) {
                    NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
                }
            }
        }
        completion();
    }];
}

@end
