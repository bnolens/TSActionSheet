//
//  TSActionSheetViewController.h
//  True Story
//
//  Created by Benoit Nolens on 4/24/15.
//  Copyright (c) 2015 True Story. All rights reserved.
//

@import Foundation;
@import UIKit;

@protocol TSActionSheetDelegate;

@interface TSActionSheetViewController : UIViewController

@property (strong, nonatomic) NSString * __nullable sheetTitle;
@property (strong, nonatomic) NSString * __nullable cancelButtonTitle;
@property (strong, nonatomic) NSString * __nullable destructiveButtonTitle;
@property (strong, nonatomic) NSArray * __nullable otherButtonTitles;

// We cannot make the delegate weak.
// We manually release it when we stop needing it
@property (strong, nonatomic) id<TSActionSheetDelegate> __nullable delegate;

#pragma mark UI customization

@property (strong, nonatomic) UIColor * __nullable destructiveButtonBackgroundColor;
@property (strong, nonatomic) UIColor * __nullable destructiveButtonTextColor;
@property (strong, nonatomic) UIColor * __nullable otherButtonBackgroundColor;
@property (strong, nonatomic) UIFont * __nullable buttonTitleFont;

- (void) prepareForShow;
- (CGFloat) calculatedHeight;

@end

@interface TSActionSheetViewController (UICollectionViewDelegateSource) <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@end

@protocol TSActionSheetDelegate <NSObject>

- (void) contentViewController:(TSActionSheetViewController* __nonnull)contentViewController onTapWithIndex:(NSUInteger)index;

@end
