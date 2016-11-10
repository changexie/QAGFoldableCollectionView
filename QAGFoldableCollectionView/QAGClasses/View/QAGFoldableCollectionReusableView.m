//
//  QAGFoldableCollectionReusableView.m
//  QAGFoldableCollectionView
//
//  Created by Changexie on 2016/11/9.
//  Copyright © 2016年 Changexie. All rights reserved.
//

#import "QAGFoldableCollectionReusableView.h"

#import "QAGGroupModel.h"

@interface QAGFoldableCollectionReusableView ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;

@property (nonatomic, assign) CGAffineTransform originalTransform;

@end

@implementation QAGFoldableCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _originalTransform = _arrowImageView.transform;
}

- (void)setGroupModel:(QAGGroupModel *)groupModel {
    _groupModel = groupModel;
    
    _nameLabel.text = groupModel.name;
    
    if (!groupModel.isFoldable) {
        _arrowImageView.hidden = YES;
    }
    
    _arrowImageView.transform = _originalTransform;
    if (groupModel.isOpen) {
        // 顺时针旋转90° (打开)
        _arrowImageView.transform = CGAffineTransformRotate(_arrowImageView.transform, M_PI_2);
    }
}

- (IBAction)didHeaderViewTouchUpInside:(id)sender {
    if (!_groupModel.isFoldable) {
        return;
    }
    
    if (_groupModel.isOpen) {
        // 逆时针旋转90° (关闭)
        _arrowImageView.transform = CGAffineTransformRotate(_arrowImageView.transform, -M_PI_2);
    } else {
        // 顺时针旋转90° (打开)
        _arrowImageView.transform = CGAffineTransformRotate(_arrowImageView.transform, M_PI_2);
    }
    _groupModel.open = !_groupModel.isOpen;
    
    if (_delegate && [_delegate respondsToSelector:@selector(headerViewClicked:)]) {
        [_delegate headerViewClicked:self];
    }
}

@end
