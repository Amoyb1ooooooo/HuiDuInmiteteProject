//
//  ArticleManager.h
//  HuiDuProject
//
//  Created by Amoyb1oo on 16/8/20.
//  Copyright © 2016年 Amoyb1oo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ArticleManagerDelegate <NSObject>

@optional
- (void)updataArticleList;
- (void)updataArticleDetail;

@end


@interface ArticleManager : NSObject
- (void)getArticleList;
- (void)getArticleDetail;

@property(nonatomic,strong) id<ArticleManagerDelegate> delegate;
@property(nonatomic,strong) NSMutableArray *articleListDataSource;
@property (nonatomic,strong)NSDictionary *articleDetailDataSource;


@end
