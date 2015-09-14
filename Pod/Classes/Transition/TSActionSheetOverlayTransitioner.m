//
//  TSActionSheetOverlayAnimatedTransitioner.m
//  True Story
//
//  Created by Benoit Nolens on 2/2/15.
//  Copyright (c) 2015 True Story. All rights reserved.
//

#import "TSActionSheetOverlayTransitioner.h"
#import "TSActionSheetOverlayPresentationController.h"

@implementation TSActionSheetOverlayTransitioningDelegate

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {

    TSActionSheetOverlayPresentationController *presentationController =
    [[TSActionSheetOverlayPresentationController alloc]
     initWithPresentedViewController:presented
     presentingViewController:presenting
     backgroundType:self.backgroundType backgroundAlpha:self.backgroundAlpha];

    presentationController.contentHeight = self.contentHeight;
    return presentationController;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {

    TSActionSheetOverlayAnimatedTransitioning *animationController = [TSActionSheetOverlayAnimatedTransitioning new];
    animationController.isPresentation = YES;
    animationController.contentHeight = self.contentHeight;

    return animationController;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {

    TSActionSheetOverlayAnimatedTransitioning *animationController = [TSActionSheetOverlayAnimatedTransitioning new];
    animationController.isPresentation = NO;
    animationController.contentHeight = self.contentHeight;

    return animationController;
}
@end

@implementation TSActionSheetOverlayAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {

    return 0.35f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {

    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = [fromVC view];
    UIViewController *toVC   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = [toVC view];

    UIView *containerView = [transitionContext containerView];

    BOOL isPresentation = [self isPresentation];

    if(isPresentation) {

        [containerView addSubview:toView];
    }

    if (!isPresentation) {
        fromView.userInteractionEnabled = NO;
        containerView.userInteractionEnabled = NO;
    }

    UIViewController *animatingVC = isPresentation? toVC : fromVC;
    UIView *animatingView = [animatingVC view];

    [animatingView setFrame:[transitionContext finalFrameForViewController:animatingVC]];

    CGAffineTransform presentedTransform = CGAffineTransformIdentity;
    CGAffineTransform startPresentedTransform = CGAffineTransformMakeTranslation(0, self.contentHeight);

    [animatingView setTransform:isPresentation ? startPresentedTransform : presentedTransform];

    [UIView animateWithDuration:isPresentation ? [self transitionDuration:transitionContext] : .3f
                          delay:0
         usingSpringWithDamping:isPresentation ? 2.f : .8f
          initialSpringVelocity:isPresentation ? .75 : 0
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [animatingView setTransform:isPresentation ? presentedTransform : startPresentedTransform];
                     }
                     completion:^(BOOL finished){
                         if(![self isPresentation])
                         {
                             [fromView removeFromSuperview];
                         }
                         [transitionContext completeTransition:YES];
                     }];
}

@end
