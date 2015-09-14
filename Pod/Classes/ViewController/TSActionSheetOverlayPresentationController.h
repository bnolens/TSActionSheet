//
//  TSActionSheetOverlayPresentationController.h
//  True Story
//
//  Created by Benoit Nolens on 2/2/15.
//  Copyright (c) 2015 True Story. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSActionSheet.h"

@interface TSActionSheetOverlayPresentationController : UIPresentationController

@property (nonatomic, strong, readonly) UIView *dimmingView;
@property (assign, nonatomic) CGFloat contentHeight;

- (instancetype) initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController backgroundType:(TSActionSheetBackgroundType)backgroundType
                                 backgroundAlpha:(CGFloat)backgroundAlpha NS_DESIGNATED_INITIALIZER;

@end
