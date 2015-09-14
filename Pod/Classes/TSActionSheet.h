//
//  TSActionSheet.h
//  True Story
//
//  Created by Benoit Nolens on 9/8/15.
//  Copyright © 2015 True Story. All rights reserved.
//

@import Foundation;
@import UIKit;

@class TSActionSheet;

typedef NS_ENUM(NSInteger, TSActionSheetBackgroundType) {
    TSActionSheetBackgroundTypeDimmedBlack,
    TSActionSheetBackgroundTypeDimmedWhite,
    TSActionSheetBackgroundTypeBlurredDark,
    TSActionSheetBackgroundTypeBlurredLight,
    TSActionSheetBackgroundTypeBlurredExtraLight
};

typedef void (^TSActionSheetCompletionBlock) (TSActionSheet * __nonnull actionSheet, NSInteger buttonIndex);

///Custom UIActionSheet
@interface TSActionSheet : NSObject

/** Title displayed on top of the actionSheet */
@property (strong, nonatomic, nullable) NSString * title;

/** Title of the cancel button (only visible if destructiveButtonTitle is nil) */
@property (strong, nonatomic, nullable) NSString * cancelButtonTitle;

/** Title of the destructive button */
@property (strong, nonatomic, nullable) NSString * destructiveButtonTitle;

/** Array of button titles */
@property (strong, nonatomic, nullable) NSArray * otherButtonTitles;

/** Block executed when tapping on one of the buttons */
@property (copy, nonatomic, nullable) TSActionSheetCompletionBlock tapBlock;

/** Background type when the actionSheet is visible 
 TSActionSheetBackgroundTypeDimmedBlack
 TSActionSheetBackgroundTypeDimmedWhite
 TSActionSheetBackgroundTypeBlurredDark
 TSActionSheetBackgroundTypeBlurredLight
 TSActionSheetBackgroundTypeBlurredExtraLight
 */
@property (assign, nonatomic) TSActionSheetBackgroundType backgroundType;

/** The alpha of the background when the actionSheet is visible. The alpha is not applied when the background is one of the blurred types */
@property (assign, nonatomic) CGFloat backgroundAlpha;

#pragma mark UI customization

/** Background color of the destructive button */
@property (strong, nonatomic, nullable) UIColor * destructiveButtonBackgroundColor;

/** Text color of the destructive button */
@property (strong, nonatomic, nullable) UIColor * destructiveButtonTextColor;

/** Background color of the other buttons */
@property (strong, nonatomic, nullable) UIColor * otherButtonBackgroundColor;

/** Font of the button titles. Used for all the buttons */
@property (strong, nonatomic, nullable) UIFont * buttonTitleFont;

/**
 
 Method to show the actionSheet. You need to create an instance of the actionSheet first and configure it using its parameters.
 @author bnolens
 @param viewController The viewController on which you want to show the actionSheet.
 
 */
- (void) showFrom:(nonnull UIViewController*)viewController;

/**
 
 Quick class method to show a custom actionSheet
 @author bnolens
 @param viewController The viewController on which you want to show the actionSheet.
 @param title Title display on top of the actionSheet
 @param cancelbuttonTitle Title of the cancel button (only visible if destructiveButtonTitle is nil)
 @param destructiveButtonTitle Title of the destructive button
 @param otherButtonTitle Array of button titles
 @param tapBlock Block executed when tapping on one of the buttons
 
 */
+ (void) showFrom:(nonnull UIViewController*)viewController
        withTitle:(nullable NSString *)title
cancelButtonTitle:(nullable NSString *)cancelButtonTitle
destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle
otherButtonTitles:(nullable NSArray *)otherButtonTitles
         tapBlock:(nullable TSActionSheetCompletionBlock)tapBlock;

- (void) hide;

@end
