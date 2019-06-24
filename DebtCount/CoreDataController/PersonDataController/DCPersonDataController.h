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
#import "DCPersonMO+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCPersonDataController : NSObject

@property (strong, nonatomic) NSPersistentContainer *persistentContainer;

+ (id)shared;
- (id)init;
- (void)savePersonData:(DCPerson *)person;

@end

NS_ASSUME_NONNULL_END
