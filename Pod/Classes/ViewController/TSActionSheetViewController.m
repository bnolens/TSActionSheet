//
//  TSActionSheetViewController.m
//  True Story
//
//  Created by Benoit Nolens on 4/24/15.
//  Copyright (c) 2015 True Story. All rights reserved.
//

NSString *const kActionSheetIdentifier = @"kTSActionSheetIdentifier";
CGFloat const kPaddingTop = 0.f;
CGFloat const kPaddingLeft = 9.f;
CGFloat const kPaddingBottom = 9.f;
CGFloat const kPaddingRight = 9.f;

#import "TSActionSheetViewController.h"
#import "TSActionSheetCell.h"

@interface TSActionSheetViewController ()

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *actionsheetHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *actionsheetPaddingRight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *actionsheetPaddingLeft;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *actionsheetPaddingBottom;

@end

@implementation TSActionSheetViewController

- (instancetype) initWithCoder:(NSCoder *)aDecoder {

    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self setup];
    }
    return self;
}

- (instancetype) init {

    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.actionsheetHeight.constant = self.calculatedHeight;
}

#pragma mark - Configure

- (void) setup {

    // Set default values
    self.destructiveButtonBackgroundColor = [UIColor colorWithRed:242.f/255.f green:67.f/255.f blue:67.f/255.f alpha:1.f];
    self.destructiveButtonTextColor = [UIColor whiteColor];
    self.otherButtonBackgroundColor = [UIColor whiteColor];
    self.buttonTitleFont = [UIFont systemFontOfSize:17];
}

- (void) configureViews {

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollEnabled = NO;
    self.collectionView.backgroundColor = [UIColor clearColor];

    // Rounded corners
    self.collectionView.clipsToBounds = YES;
    self.collectionView.layer.cornerRadius = 3.f;

    // Set cell
    UINib *nib = [UINib nibWithNibName:@"TSActionSheetCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:kActionSheetIdentifier];

    self.actionsheetPaddingBottom.constant = 9.f;
    self.actionsheetPaddingLeft.constant = 9.f;
    self.actionsheetPaddingRight.constant = 9.f;
}

#pragma mark - Navigation

#pragma mark - Public methods

- (void) prepareForShow {

    [self.collectionView reloadData];
    self.actionsheetHeight.constant = self.calculatedHeight;
}

- (CGFloat) calculatedHeight {

    BOOL hasCancelButton = (self.cancelButtonTitle || self.destructiveButtonTitle);
    return (self.otherButtonTitles.count * 50.f) + (hasCancelButton ? 50 : 0) + kPaddingBottom;
}

@end


#pragma mark - UICollectionViewDelegateSource

@implementation TSActionSheetViewController (UICollectionViewDelegateSource)

- (NSInteger) collectionView:(UICollectionView *)collectionView
      numberOfItemsInSection:(NSInteger)section {

    if (section == 0) {

        return (self.otherButtonTitles) ? self.otherButtonTitles.count : 0;

    } else if(section == 1) {

        BOOL hasCancelButton = (self.cancelButtonTitle || self.destructiveButtonTitle);
        return hasCancelButton ? 1 : 0;
    }

    return 0;
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    BOOL hasCancelButton = (self.cancelButtonTitle || self.destructiveButtonTitle);
    return (hasCancelButton ? 2 : 1);
}

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    BOOL hasCancelButton = (self.cancelButtonTitle || self.destructiveButtonTitle);

    TSActionSheetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kActionSheetIdentifier forIndexPath:indexPath];

    cell.titleLabel.font = self.buttonTitleFont;
    cell.contentView.backgroundColor = self.otherButtonBackgroundColor;

    if (hasCancelButton && indexPath.section == 1) {
        if (self.destructiveButtonTitle) {
            cell.titleLabel.text = self.destructiveButtonTitle;
            cell.contentView.backgroundColor = self.destructiveButtonBackgroundColor;
            cell.titleLabel.textColor = self.destructiveButtonTextColor;
        } else {
            cell.titleLabel.text = self.cancelButtonTitle;
        }
    } else if(indexPath.section == 0) {
        cell.titleLabel.text = self.otherButtonTitles[indexPath.item];
    }

    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    NSUInteger index = 0;

    if (indexPath.section == 0) {
        index = indexPath.item;
    } else if(indexPath.section == 1) {
        index = self.otherButtonTitles.count + 1;
    }

    id<TSActionSheetDelegate>strongDel = self.delegate;
    if (strongDel && [strongDel respondsToSelector:@selector(contentViewController:onTapWithIndex:)]) {
        [strongDel contentViewController:self onTapWithIndex:index];
    }
}

- (void)collectionView:(UICollectionView *)collectionView
didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake(collectionView.frame.size.width, 50.f);
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {

    return 0;
}


- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {

    if (section == 0) {
        return 0.5f;
    } else {
        return 0.f;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {

    if (!self.destructiveButtonTitle && self.cancelButtonTitle) {
        return CGSizeMake(0.f, 0.5f);
    } else {
        return CGSizeMake(0.f, 0.f);
    }
}

@end
