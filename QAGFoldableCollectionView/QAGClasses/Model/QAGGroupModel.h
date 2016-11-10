//
//  QAGGroupModel.h
//  QAGFoldableCollectionView
//
//  Created by bltech on 16/11/10.
//  Copyright © 2016年 Changexie. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QAGChildModel;

@interface QAGGroupModel : NSObject

/**
 组模型名字
 */
@property (nonatomic, copy) NSString *name;

/**
 是否开启
 */
@property (nonatomic, assign, getter=isOpen) BOOL open;

/**
 子模型数组
 */
@property (nonatomic, strong) NSMutableArray<QAGChildModel *> *childModels;

@end
