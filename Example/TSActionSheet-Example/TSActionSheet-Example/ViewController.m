//
//  ViewController.m
//  TSActionSheet-Example
//
//  Created by Benoit Nolens on 9/14/15.
//  Copyright © 2015 True Story. All rights reserved.
//

#import "ViewController.h"
#import "TSActionSheet.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (IBAction) showFastActionSheet:(id)sender {
    
    // Fast way to show a custom actionSheet on the screen
    
    [TSActionSheet showFrom:self
                  withTitle:nil
          cancelButtonTitle:nil
     destructiveButtonTitle:NSLocalizedString(@"Cancel", nil)
          otherButtonTitles:@[NSLocalizedString(@"Option 1", nil), NSLocalizedString(@"Option 2", nil)]
                   tapBlock:^(TSActionSheet * _Nonnull actionSheet, NSInteger buttonIndex) {
        
    }];
}

- (IBAction) showDetailedActionSheet:(id)sender {
    
    // Detailed and customizable way to show a custom actionSheet on the screen
    
    TSActionSheet *actionSheet = [TSActionSheet new];
    actionSheet.otherButtonTitles = @[@"Option A", @"Option B", @"Option C"];
    actionSheet.destructiveButtonTitle = @"Cancel";
    
    // UI Customization
    actionSheet.otherButtonBackgroundColor = [UIColor colorWithWhite:0.94 alpha:1.f];
    actionSheet.buttonTitleFont = [UIFont systemFontOfSize:19];
    actionSheet.backgroundType = TSActionSheetBackgroundTypeBlurredLight;
    actionSheet.destructiveButtonBackgroundColor = [UIColor blackColor];
    actionSheet.destructiveButtonTextColor = [UIColor whiteColor];
    
    actionSheet.tapBlock =  ^(TSActionSheet * _Nonnull as, NSInteger buttonIndex) {
        
    };
    
    [actionSheet showFrom:self];
}

@end
