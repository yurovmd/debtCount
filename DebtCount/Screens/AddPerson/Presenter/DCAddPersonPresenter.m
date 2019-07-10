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
- (void)saveImage;

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
    self.person.personId = [[NSUUID UUID] UUIDString];
    [self.view stopAvatarLoadingActivityView];
}

- (void)userChangedNameString:(NSString *)string {
    [self.person setName:string];
}

- (void)userChangedRelationString:(NSString *)string {
    [self.person setRelation:string];
}

- (void)okPressed {
    // Validating data
    void (^responseCompletion)(DCPersonValidationResponse *) = ^(DCPersonValidationResponse *response) {
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

- (void)pictureTaken:(UIImage *)picture {
    self.person.avatar = picture;
    [self.view disableOkButton];
    [self.view startAvatarLoadingActivityView];
    [self saveImage];
}

@end

// MARK: - Private Collection

@implementation DCAddPersonPresenter (Private)

- (void)saveData:(DCPerson *)person {
    void (^completion)(NSString *error) = ^(NSString *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view closePopoverAndReload];
        });
    };
    [DCStorageDataProvider.shared.manager postPerson:person
                                          completion:(completion)];

}

- (void)saveImage {
    void (^completion)(NSString *imageUrl,
                       NSString *error) = ^(NSString *imageUrl,
                                            NSString *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error != nil) {
                NSLog(@"%@", error);
                [self.view setAvatar:[UIImage imageNamed:@"no_network"]];
                self.person.avatarUrl = @"";
            } else {
                self.person.avatarUrl = imageUrl;
                [self.view setAvatar:self.person.avatar];
            }
            [self.view enableOkButton];
            [self.view stopAvatarLoadingActivityView];
        });
    };
    [DCStorageDataProvider.shared.manager postImage:self.person.avatar
                                         completion:completion];
}

@end
