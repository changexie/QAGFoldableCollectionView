//
//  QAGFoldableCollectionView.h
//  QAGFoldableCollectionView
//
//  Created by Changexie on 2016/11/9.
//  Copyright © 2016年 Changexie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QAGGroupModel;

@interface QAGFoldableCollectionView : UIView

+ (instancetype)collectionView;

@property (nonatomic, strong) NSMutableArray<QAGGroupModel *> *groupModels;

@end
