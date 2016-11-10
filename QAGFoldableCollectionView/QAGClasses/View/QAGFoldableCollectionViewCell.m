//
//  QAGFoldableCollectionViewCell.m
//  QAGFoldableCollectionView
//
//  Created by Changexie on 2016/11/9.
//  Copyright © 2016年 Changexie. All rights reserved.
//

#import "QAGFoldableCollectionViewCell.h"

#import "QAGChildModel.h"

@interface QAGFoldableCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation QAGFoldableCollectionViewCell

- (void)setChildModel:(QAGChildModel *)childModel {
    _childModel = childModel;
    
    _nameLabel.text = childModel.name;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

@end
