//
//  TSActionSheet.m
//  True Story
//
//  Created by Benoit Nolens on 9/8/15.
//  Copyright © 2015 True Story. All rights reserved.
//

#import "TSActionSheet.h"
#import "TSActionSheetViewController.h"
#import "TSActionSheetOverlayTransitioner.h"

static TSActionSheetOverlayTransitioningDelegate *transitionDelegate;

@interface TSActionSheet() <TSActionSheetDelegate>

@property (strong, nonatomic) TSActionSheetViewController *contentViewController;

@end

@implementation TSActionSheet

#pragma mark - Initialisation

- (instancetype) init {

    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void) setup {

    NSBundle *bundle = [NSBundle bundleForClass:[TSActionSheetViewController class]];
    self.contentViewController = [[TSActionSheetViewController alloc] initWithNibName:[NSString stringWithFormat:@"UserInterface.bundle/%@", NSStringFromClass([TSActionSheetViewController class])] bundle:bundle];
    self.contentViewController.modalPresentationStyle = UIModalPresentationCustom;
    self.contentViewController.transitioningDelegate = self.transitionDelegate;
    self.contentViewController.delegate = self;

    self.backgroundType = TSActionSheetBackgroundTypeDimmedBlack;
    self.backgroundAlpha = 0.66f;
}

- (TSActionSheetOverlayTransitioningDelegate*) transitionDelegate {

    if (!transitionDelegate) {
        transitionDelegate = [TSActionSheetOverlayTransitioningDelegate new];
    }

    return transitionDelegate;
}

- (void) setTitle:(NSString *)title {

    _title = title;
    self.contentViewController.sheetTitle = title;
}

- (void) setCancelButtonTitle:(NSString *)cancelButtonTitle {

    _cancelButtonTitle = cancelButtonTitle;
    self.contentViewController.cancelButtonTitle = cancelButtonTitle;
}

- (void) setDestructiveButtonTitle:(NSString *)destructiveButtonTitle {

    _destructiveButtonTitle = destructiveButtonTitle;
    self.contentViewController.destructiveButtonTitle = destructiveButtonTitle;
}

- (void) setDestructiveButtonTextColor:(UIColor *)destructiveButtonTextColor {

    _destructiveButtonTextColor = destructiveButtonTextColor;
    self.contentViewController.destructiveButtonTextColor = destructiveButtonTextColor;
}

- (void) setOtherButtonTitles:(NSArray *)otherButtonTitles {

    _otherButtonTitles = otherButtonTitles;
    self.contentViewController.otherButtonTitles = otherButtonTitles;
}

- (void) setDestructiveButtonBackgroundColor:(UIColor *)destructiveButtonBackgroundColor {

    _destructiveButtonBackgroundColor = destructiveButtonBackgroundColor;
    self.contentViewController.destructiveButtonBackgroundColor = destructiveButtonBackgroundColor;
}

- (void) setOtherButtonBackgroundColor:(UIColor *)otherButtonBackgroundColor {

    _otherButtonBackgroundColor = otherButtonBackgroundColor;
    self.contentViewController.otherButtonBackgroundColor = otherButtonBackgroundColor;
}

- (void) setButtonTitleFont:(UIFont *)buttonTitleFont {

    _buttonTitleFont = buttonTitleFont;
    self.contentViewController.buttonTitleFont = buttonTitleFont;
}


#pragma mark - Private methods

- (void) prepareForShow {
    
    [self.contentViewController prepareForShow];
    self.transitionDelegate.contentHeight = self.contentViewController.calculatedHeight;
    self.transitionDelegate.backgroundType = self.backgroundType;
    self.transitionDelegate.backgroundAlpha = self.backgroundAlpha;
}

#pragma mark - Public methods

- (void) showFrom:(UIViewController*)viewController {

    [self prepareForShow];
    [viewController presentViewController:self.contentViewController animated:YES completion:nil];
}

+ (void) showFrom:(UIViewController*)viewController
        withTitle:(NSString *)title
cancelButtonTitle:(NSString *)cancelButtonTitle
destructiveButtonTitle:(NSString *)destructiveButtonTitle
otherButtonTitles:(NSArray *)otherButtonTitles
         tapBlock:(TSActionSheetCompletionBlock)tapBlock {

    TSActionSheet *actionSheet = [TSActionSheet new];
    actionSheet.title = title;
    actionSheet.cancelButtonTitle = cancelButtonTitle;
    actionSheet.destructiveButtonTitle = destructiveButtonTitle;
    actionSheet.otherButtonTitles = otherButtonTitles;
    actionSheet.tapBlock = tapBlock;
    [actionSheet prepareForShow];
    [viewController presentViewController:actionSheet.contentViewController animated:YES completion:nil];
}

- (void) hide {

    [self.contentViewController dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - TSActionSheetViewControllerDelegate

- (void) contentViewController:(TSActionSheetViewController *)contentViewController onTapWithIndex:(NSUInteger)index {

    [self hide];
    
    if (self.tapBlock) {
        self.tapBlock(self, index);
    }
    
    contentViewController.delegate = nil;
}

@end
