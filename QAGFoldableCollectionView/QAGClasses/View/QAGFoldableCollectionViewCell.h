//
//  QAGFoldableCollectionViewCell.h
//  QAGFoldableCollectionView
//
//  Created by Changexie on 2016/11/9.
//  Copyright © 2016年 Changexie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QAGChildModel;

@interface QAGFoldableCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) QAGChildModel *childModel;

@end
