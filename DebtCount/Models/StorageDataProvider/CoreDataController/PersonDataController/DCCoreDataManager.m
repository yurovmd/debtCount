//
//  PersonDataController.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 24/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCCoreDataManager.h"
#import "DCDataSerializer.h"
#import "DCDataDeserializer.h"

@implementation DCCoreDataManager

- (instancetype)init {
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

@end

// MARK: - DCStorageDataProviderProtocol

@implementation DCCoreDataManager (DCStorageDataProviderProtocol)

- (void)getPersonsWithCompletion:(void(^)(NSMutableArray *persons, NSString *error))completion {

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
        completion(persons, nil);
    }];
}

- (void)getTransactionsForPersonId:(NSString *)personId
                        completion:(void(^)(NSMutableArray *transactions, NSString *error))completion {

}

- (void)postPerson:(DCPerson *)person
        completion:(void(^)(void))completion {
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

- (void)postTransaction:(DCTransaction *)transaction
              forPersonId:(NSString *)personId
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
            if ([personMO.personId isEqualToString:personId]) {
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

- (void)deletePersonById:(NSString *)personId
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
            if ([personMO.personId isEqualToString:personId]) {
                [context deleteObject:personMO];
                if ([context save:&error] == NO) {
                    NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
                }
            }
        }
        completion();
    }];
}

- (void)deleteTransactionForPersonId:(NSString *)personId
                   withTransaction:(DCTransaction *)transaction
                          completion:(void(^)(void))completion {
    [self.persistentContainer performBackgroundTask:^(NSManagedObjectContext * _Nonnull context) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DCTransactionMO"];
        NSError *error = nil;
        NSArray *results = [context executeFetchRequest:request error:&error];
        if (!results) {
            NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
            abort();
        }
        for (DCTransactionMO *transactionMO in results) {
            if ([transactionMO.person.personId isEqualToString:personId]) {
                [transactionMO.person setDebt:[transactionMO.person.debt decimalNumberBySubtracting:transaction.amount]];
                [context deleteObject:transactionMO];
                if ([context save:&error] == NO) {
                    NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
                }
            }
        }
        completion();
    }];
}

- (void)postImage:(UIImage *)image
       completion:(void(^)(NSString *imageUrl, NSString *error))completion {
    
}

- (void)getImageWithURLString:(NSString *)imageURLString
                   completion:(void(^)(UIImage *image, NSString *error))completion {
    
}

@end

