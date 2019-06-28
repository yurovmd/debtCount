//
//  DCPersonsListDelegate.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 28/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCPerson.h"

#ifndef DCPersonsListDelegate_h
#define DCPersonsListDelegate_h

@protocol DCPersonsListDelegate <NSObject>

- (void)personSelected:(DCPerson *)person;

@end

#endif /* DCPersonsListDelegate_h */
