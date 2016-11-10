//
//  QAGFoldableCollectionReusableView.h
//  QAGFoldableCollectionView
//
//  Created by Changexie on 2016/11/9.
//  Copyright © 2016年 Changexie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QAGFoldableCollectionReusableView, QAGGroupModel;

@protocol QAGFoldableCollectionReusableViewDelegate <NSObject>

- (void)headerViewClicked:(QAGFoldableCollectionReusableView *)headerView;

@end

@interface QAGFoldableCollectionReusableView : UICollectionReusableView

@property (nonatomic, strong) QAGGroupModel *groupModel;

@property (nonatomic, weak) id<QAGFoldableCollectionReusableViewDelegate> delegate;

@end
