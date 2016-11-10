//
//  QAGGroupModel.m
//  QAGFoldableCollectionView
//
//  Created by bltech on 16/11/10.
//  Copyright © 2016年 Changexie. All rights reserved.
//

#import "QAGGroupModel.h"

@implementation QAGGroupModel

- (NSMutableArray<QAGChildModel *> *)childModels {
    if (!_childModels) {
        _childModels = [NSMutableArray array];
    }
    return _childModels;
}

- (BOOL)isOpen {
    return _open;
}

@end
