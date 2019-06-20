//
//  AddPersonPresenter.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 20/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddPersonViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddPersonPresenter : NSObject

- (instancetype)initWithView:(AddPersonViewController *)view;

- (void)viewIsReady;
- (void)userChangedNameString:(NSString *)string;
- (void)userChangedRelationString:(NSString *)string;
- (void)okPressed;
- (void)cancelPressed;
- (void)changePicturePressed;

@end

NS_ASSUME_NONNULL_END
