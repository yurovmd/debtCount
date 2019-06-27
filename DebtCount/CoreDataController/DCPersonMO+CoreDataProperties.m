//
//  DCPersonMO+CoreDataProperties.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 27/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//
//

#import "DCPersonMO+CoreDataProperties.h"

@implementation DCPersonMO (CoreDataProperties)

+ (NSFetchRequest<DCPersonMO *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"DCPersonMO"];
}

@dynamic avatar;
@dynamic debt;
@dynamic name;
@dynamic personId;
@dynamic relation;
@dynamic transactions;

@end
