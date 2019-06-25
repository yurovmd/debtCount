//
//  DCPersonMO+CoreDataProperties.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 24/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//
//

#import "DCPersonMO+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface DCPersonMO (CoreDataProperties)

+ (NSFetchRequest<DCPersonMO *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *relation;
@property (nullable, nonatomic, copy) NSDecimalNumber *debt;
@property (nullable, nonatomic, retain) NSData *avatar;
@property (nullable, nonatomic, copy) NSString *personId;

@end

NS_ASSUME_NONNULL_END
