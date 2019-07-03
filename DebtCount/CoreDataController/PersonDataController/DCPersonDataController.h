//
//  PersonDataController.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 24/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "DCPerson.h"
#import "DCTransaction.h"
#import "DCTransactionMO+CoreDataClass.h"
#import "DCPersonMO+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCPersonDataController : NSObject

@property (strong, nonatomic) NSPersistentContainer *persistentContainer;

+ (id)shared;
- (id)init;
- (void)savePersonData:(DCPerson *)person completion:(void(^)(void))completion;
- (void)fetchPersonsWithCompletion:(void (^)(NSMutableArray *persons))completion;
- (void)saveTransactionData:(DCTransaction *)transaction
                  forPerson:(DCPerson *)person
                 completion:(void(^)(void))completion;
- (void)deletePerson:(DCPerson *)person completion:(void(^)(void))completion;

@end

NS_ASSUME_NONNULL_END
