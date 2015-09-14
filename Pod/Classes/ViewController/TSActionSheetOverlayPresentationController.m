//
//  TSActionSheetOverlayPresentationController.m
//  True Story
//
//  Created by Benoit Nolens on 2/2/15.
//  Copyright (c) 2015 True Story. All rights reserved.
//

#import "TSActionSheetOverlayPresentationController.h"
#import "TSActionSheetViewController.h"

@interface TSActionSheetOverlayPresentationController()

@property (nonatomic, strong) UIView *dimmingView;

@end

@implementation TSActionSheetOverlayPresentationController

- (instancetype) initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController backgroundType:(TSActionSheetBackgroundType)backgroundType backgroundAlpha:(CGFloat)backgroundAlpha {

    if (self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController]) {

        [self prepareDimmingViewWithType:backgroundType alpha:backgroundAlpha];
    }

    return self;
}

- (void) presentationTransitionWillBegin {

    [super presentationTransitionWillBegin];

    UIView* containerView = [self containerView];
    UIViewController* presentedViewController = [self presentedViewController];
    [self.dimmingView setFrame:[containerView bounds]];
    [self.dimmingView setAlpha:0.0];
    self.dimmingView.userInteractionEnabled = YES;

    [containerView insertSubview:self.dimmingView atIndex:0];

    if([presentedViewController transitionCoordinator])
    {
        [[presentedViewController transitionCoordinator] animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            [self.dimmingView setAlpha:1.0];
        } completion:nil];
    }
    else
    {
        [self.dimmingView setAlpha:1.0];
    }
}

- (void)dismissalTransitionWillBegin {

    self.dimmingView.userInteractionEnabled = NO;

    if([[self presentedViewController] transitionCoordinator])
    {
        [[[self presentedViewController] transitionCoordinator] animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            [self.dimmingView setAlpha:0.0];
        } completion:nil];
    }
    else
    {
        [self.dimmingView setAlpha:0.0];
    }
}

- (CGSize)sizeForChildContentContainer:(id <UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {

    return CGSizeMake(parentSize.width, parentSize.height);
}

- (void)containerViewWillLayoutSubviews {

    [self.dimmingView setFrame:[[self containerView] bounds]];
}

- (CGRect)frameOfPresentedViewInContainerView {

    CGRect containerBounds = [[self containerView] bounds];

    CGFloat viewHeight = self.contentHeight;

    CGRect presentedViewFrame = containerBounds;
    presentedViewFrame.size = CGSizeMake(containerBounds.size.width, viewHeight);
    presentedViewFrame.origin = CGPointMake(0, containerBounds.size.height - viewHeight);

    return presentedViewFrame;
}

@synthesize dimmingView;

- (void)prepareDimmingViewWithType:(TSActionSheetBackgroundType)type alpha:(CGFloat)alpha {

    self.dimmingView = [[UIView alloc] init];

    switch (type) {
        case TSActionSheetBackgroundTypeBlurredDark: {

            if ([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending) {

                UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
                UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
                visualEffectView.frame = self.containerView.frame;
                visualEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                [self.dimmingView addSubview:visualEffectView];
            } else {
                [self.dimmingView setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:alpha]];
            }

            break;
        }

        case TSActionSheetBackgroundTypeBlurredLight: {

            if ([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending) {

                UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
                UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
                visualEffectView.frame = self.containerView.frame;
                visualEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                [self.dimmingView addSubview:visualEffectView];
            } else {
                [self.dimmingView setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:alpha]];
            }

            break;
        }

        case TSActionSheetBackgroundTypeBlurredExtraLight: {

            if ([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending) {

                UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
                UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
                visualEffectView.frame = self.containerView.frame;
                visualEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                [self.dimmingView addSubview:visualEffectView];
            } else {
                [self.dimmingView setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:alpha]];
            }

            break;
        }

        case TSActionSheetBackgroundTypeDimmedBlack: {

            [self.dimmingView setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:alpha]];

            break;
        }

        case TSActionSheetBackgroundTypeDimmedWhite: {

            [self.dimmingView setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:alpha]];

            break;
        }

        default:

            [self.dimmingView setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:alpha]];

            break;
    }

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dimmingViewTapped:)];
    [self.dimmingView addGestureRecognizer:tap];
}

- (void)dimmingViewTapped:(UIGestureRecognizer *)gesture {

    if([gesture state] == UIGestureRecognizerStateRecognized) {

        [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    }
}

- (BOOL) shouldRemovePresentersView {
    return NO;
}
@end
