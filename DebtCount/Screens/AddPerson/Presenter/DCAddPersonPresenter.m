//
//  AddPersonPresenter.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 20/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCAddPersonPresenter.h"

#import "DCPerson.h"
#import "DCValidator.h"

@interface DCAddPersonPresenter ()

@property id<DCValidatorProtocol> validator;
@property (weak) DCAddPersonViewController *view;
@property DCPerson *person;

@end

@interface DCAddPersonPresenter (PrivateCollection)

- (void)saveData:(DCPerson *)person;

@end

@implementation DCAddPersonPresenter

- (instancetype)initWithView:(DCAddPersonViewController *)view validator:(id<DCValidatorProtocol>)validator {
    if (self = [super init]) {
        self.validator = validator;
        self.view = view;
    }
    return self;
}

- (void)viewIsReady {
    self.person = [[DCPerson alloc] init];
}

- (void)userChangedNameString:(NSString *)string {
    [self.person setName:string];
}

- (void)userChangedRelationString:(NSString *)string {
    [self.person setRelation:string];
}

- (void)okPressed {
    // Validating data
    void (^responseCompletion)(DCValidationResponse *) = ^(DCValidationResponse *response) {
        if (response.isValid) {
            [self saveData:self.person];
        } else {
            if (response.isNameValid) {
                [self.view hideNameFieldError];
            } else {
                [self.view showNameFieldError];
            }
            if (response.isRelationValid) {
                [self.view hideRelationFieldError];
            } else {
                [self.view showRelationFieldError];
            }
        }
    };
    [self.validator validatePerson:self.person completion:(responseCompletion)];
}

- (void)cancelPressed {
    [self.view closePopover];
}

- (void)changePicturePressed {
    [self.view takeAPicture];
}

@end

// MARK: - Private Collection

@implementation DCAddPersonPresenter (Private)

- (void)saveData:(DCPerson *)person {
    void (^completion)(void) = ^(void) {
        [self.view closePopoverAndReload];
    };
    [DCPersonDataController.shared savePersonData:person completion:(completion)];

}

@end
