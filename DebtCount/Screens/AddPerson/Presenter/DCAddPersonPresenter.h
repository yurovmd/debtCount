//
//  AddPersonPresenter.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 20/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "DCAddPersonViewController.h"
#import "DCValidatorProtocol.h"
#import "DCStorageDataProvider.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCAddPersonPresenter : NSObject

- (instancetype)initWithView:(DCAddPersonViewController *)view validator:(id<DCValidatorProtocol>)validator;

- (void)viewIsReady;
- (void)userChangedNameString:(NSString *)string;
- (void)userChangedRelationString:(NSString *)string;
- (void)okPressed;
- (void)cancelPressed;
- (void)changePicturePressed;
- (void)pictureTaken:(UIImage *)picture;

@end

NS_ASSUME_NONNULL_END
