//
//  TSActionSheetOverlayAnimatedTransitioner.h
//  True Story
//
//  Created by Benoit Nolens on 2/2/15.
//  Copyright (c) 2015 True Story. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSActionSheet.h"

@interface TSActionSheetOverlayTransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate>

@property (assign, nonatomic) CGFloat contentHeight;
@property (assign, nonatomic) TSActionSheetBackgroundType backgroundType;
@property (assign, nonatomic) CGFloat backgroundAlpha;

@end

@interface TSActionSheetOverlayAnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning>
@property (assign, nonatomic) BOOL isPresentation;
@property (assign, nonatomic) CGFloat contentHeight;

@end
