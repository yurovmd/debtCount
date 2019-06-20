//
//  AddPersonPresenter.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 20/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCAddPersonPresenter.h"
#import "DCAddPersonViewController.h"
#import "DCPerson.h"
#import "DCValidator.h"

@interface DCAddPersonPresenter ()

@property (weak) DCAddPersonViewController *view;
@property DCPerson *person;
@property BOOL nameFieldErrorStatus;
@property BOOL relationFieldErrorStatus;

@end

@interface DCAddPersonPresenter (PrivateCollection)

- (void)saveData:(DCPerson *)person;

@end

@implementation DCAddPersonPresenter

- (instancetype)initWithView:(DCAddPersonViewController *)view {
    if (self = [super init]) {
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
    self.relationFieldErrorStatus = NO;
    self.nameFieldErrorStatus = NO;
    DCValidationResponse *nameValidationResponse = [DCValidator checkName:self.person.name];
    switch (nameValidationResponse.errorType) {
        case DCValidationResponseTypeValid:
            self.nameFieldErrorStatus = NO;
            [self.view hideNameFieldError];
            break;
        case DCValidationResponseTypeIncorrectName:
            self.nameFieldErrorStatus = YES;
            [self.view showNameFieldError];
            break;
        case DCValidationResponseTypeIncorrectRelation:
            break;
    }
    DCValidationResponse *relationValidationResponse = [DCValidator checkRelation:self.person.relation];
    switch (relationValidationResponse.errorType) {
        case DCValidationResponseTypeValid:
            self.relationFieldErrorStatus = NO;
            [self.view hideRelationFieldError];
            break;
        case DCValidationResponseTypeIncorrectName:
            break;
        case DCValidationResponseTypeIncorrectRelation:
            self.relationFieldErrorStatus = YES;
            [self.view showRelationFieldError];
            break;
    }
    if (!self.relationFieldErrorStatus && !self.nameFieldErrorStatus) {
        [self saveData:self.person];
        [self.view closePopover];
    }
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
    // TODO: - Save data
}

@end
