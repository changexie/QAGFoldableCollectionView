//
//  QAGFoldableCollectionView.m
//  QAGFoldableCollectionView
//
//  Created by Changexie on 2016/11/9.
//  Copyright © 2016年 Changexie. All rights reserved.
//

#import "QAGFoldableCollectionView.h"

#import "QAGFoldableCollectionViewCell.h"
#import "QAGFoldableCollectionReusableView.h"

#import "QAGGroupModel.h"
#import "QAGChildModel.h"

static NSString *const kCellViewID   = @"QAGFoldableCollectionViewCell";
static NSString *const kHeaderViewID = @"QAGFoldableCollectionReusableView";

static const CGFloat kItemsSpace = 10.0f;
static const CGFloat kItemHeight = 40.0f;
static const CGFloat kSectionHeaderViewH = 50.0f;

@interface QAGFoldableCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, QAGFoldableCollectionReusableViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation QAGFoldableCollectionView

- (NSMutableArray<QAGGroupModel *> *)groupModels {
    if (!_groupModels) {
        _groupModels = [NSMutableArray array];
    }
    return _groupModels;
}

+ (instancetype)collectionView {
    QAGFoldableCollectionView *collectionView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    return collectionView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupCollectionView];
}

- (void)setupCollectionView {
    [_collectionView registerNib:[UINib nibWithNibName:kCellViewID bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kCellViewID];
    [_collectionView registerNib:[UINib nibWithNibName:kHeaderViewID bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderViewID];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.groupModels.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.groupModels[section].isOpen) {
        return self.groupModels[section].childModels.count;
    } else {
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QAGFoldableCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellViewID forIndexPath:indexPath];
    cell.childModel = self.groupModels[indexPath.section].childModels[indexPath.item];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (![kind isEqualToString:UICollectionElementKindSectionHeader]) {
        return nil;
    }
    QAGFoldableCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderViewID forIndexPath:indexPath];
    headerView.groupModel = self.groupModels[indexPath.section];
    headerView.delegate   = self;
    return headerView;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && self.groupModels[indexPath.section].childModels[indexPath.item].originalGroupNumber != 0) {
        [self backToOriginalGroup:indexPath];
        return;
    }
    if (self.groupModels[indexPath.section].childModels[indexPath.item].originalGroupNumber == 0) {
        return;
    }
    [self moveToTopGroup:indexPath];
}

- (void)backToOriginalGroup:(NSIndexPath *)indexPath {
    QAGGroupModel *topGroupModel = self.groupModels[0];
    QAGChildModel *tmpChildModel = self.groupModels[0].childModels[indexPath.item];
    [topGroupModel.childModels removeObject:tmpChildModel];
    QAGGroupModel *originalGroupModel = self.groupModels[tmpChildModel.originalGroupNumber];
    [originalGroupModel.childModels addObject:tmpChildModel];
    [_collectionView reloadData];
}

- (void)moveToTopGroup:(NSIndexPath *)indexPath {
    QAGGroupModel *tmpGroupModel = self.groupModels[indexPath.section];
    QAGChildModel *tmpChildModel = self.groupModels[indexPath.section].childModels[indexPath.item];
    [tmpGroupModel.childModels removeObject:tmpChildModel];
    QAGGroupModel *topGroupModel = self.groupModels[0];
    [topGroupModel.childModels addObject:tmpChildModel];
    [_collectionView reloadData];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeMake((self.bounds.size.width - 3 * kItemsSpace) / 2, kItemHeight);
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    UIEdgeInsets inset = UIEdgeInsetsMake(kItemsSpace / 2, kItemsSpace, kItemsSpace / 2, kItemsSpace);
    return inset;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return kItemsSpace;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return kItemsSpace;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize size = CGSizeMake(self.bounds.size.width, kSectionHeaderViewH);
    return size;
}

#pragma mark - QAGFoldableCollectionReusableViewDelegate

- (void)headerViewClicked:(QAGFoldableCollectionReusableView *)headerView {
    [_collectionView reloadData];
}

@end
