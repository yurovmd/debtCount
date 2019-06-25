//
//  DCPersonMO+CoreDataProperties.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 24/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//
//

#import "DCPersonMO+CoreDataProperties.h"

@implementation DCPersonMO (CoreDataProperties)

+ (NSFetchRequest<DCPersonMO *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"DCPersonMO"];
}

@dynamic name;
@dynamic relation;
@dynamic debt;
@dynamic avatar;
@dynamic personId;

@end
