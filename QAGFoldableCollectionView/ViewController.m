//
//  ViewController.m
//  QAGFoldableCollectionView
//
//  Created by Changexie on 2016/11/9.
//  Copyright © 2016年 Changexie. All rights reserved.
//

#import "ViewController.h"

#import "QAGFoldableCollectionView.h"

#import "QAGGroupModel.h"
#import "QAGChildModel.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray<QAGGroupModel *> *models;

@end

@implementation ViewController

- (NSMutableArray<QAGGroupModel *> *)models {
    if (!_models) {
        _models = [NSMutableArray array];
        
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"QAGData" ofType:@"plist"]];
        if (array) {
            for (NSDictionary *dict in array) {
                QAGGroupModel *model = [QAGGroupModel new];
                model.name = dict[@"name"];
                // 这里需要用 boolValue转一下, 如果直接 model.open = dict[@"open"] 会得到 YES
                model.open = [dict[@"open"] boolValue];
                model.foldable = [dict[@"foldable"] boolValue];
                NSArray *childArray = dict[@"childs"];
                for (NSDictionary *childDict in childArray) {
                    QAGChildModel *childModel = [QAGChildModel new];
                    childModel.name = childDict[@"name"];
                    
                    childModel.originalGroupNumber  = [array indexOfObject:dict];
                    childModel.originalIndexAtGroup = [childArray indexOfObject:childDict];
                    
                    [model.childModels addObject:childModel];
                }
                [_models addObject:model];
            }
        }
    }
    return _models;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"分组编辑";
    
    QAGFoldableCollectionView *collectionView = [QAGFoldableCollectionView collectionView];
    collectionView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    collectionView.groupModels = self.models;
    [self.view addSubview:collectionView];
}


@end
