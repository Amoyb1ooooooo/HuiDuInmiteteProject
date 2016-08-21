//
//  ArticleManager.m
//  HuiDuProject
//
//  Created by Amoyb1oo on 16/8/20.
//  Copyright © 2016年 Amoyb1oo. All rights reserved.
//

#import "ArticleManager.h"
#import "AFNetworking.h"
#import "Article.h"

@implementation ArticleManager

-(instancetype)init{
    self = [super init];
    if (self) {
        _articleListDataSource = [NSMutableArray arrayWithCapacity:5];
        _articleDetailDataSource = [[NSDictionary alloc]init];
        return self;
    }
    return nil;
}

- (void)getArticleList{
    NSString *url = @"http://huiduservice.lanxijun.com/articleList.json?appId=cuunyVcB1QBTmNUN&pageNum=1&pageSize=10&sign=8bycBeYXU%2B9ReEMAaqsoBGuX8WUqokSf%2FCicg1QKeNY%3D&timestamp=1471764600";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        // NSLog(@"JSON:%@",responseObject);
        // 数据解析
        NSDictionary *dic = responseObject;
        NSArray *array = [dic objectForKey:@"result"];
        for (NSDictionary *dic in array) {
            NSString *author = [dic objectForKey:@"author"];
            NSString *content = [dic objectForKey:@"content"];
            NSString *aid = [dic objectForKey:@"id"];
            NSString *publishTime = [dic objectForKey:@"publishTime"];
            NSString *shortDesc = [dic objectForKey:@"shortDesc"];
            NSString *title = [dic objectForKey:@"title"];
            NSString *url = [dic objectForKey:@"url"];
            
            Article *a = [[Article alloc]init];
            a.author = author;
            a.content = content;
            a.aid = [aid integerValue];
            a.publishTime = publishTime;
            a.shortDesc = shortDesc;
            a.title = title;
            a.url = url;
            
            [_articleListDataSource addObject:a];
        }
        
        [_delegate updataArticleList];

    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)getArticleDetail{
    NSString *url = @"http://article.lanxijun.com/articleDetail.json?appId=hQCxinnGahes5iXQ&id=42174&sign=Z968DABff1AcBnf68bU4ohffABJm83YXZBMDNq36NiQ%3D&signType=1";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        _articleDetailDataSource = responseObject;
        [_delegate updataArticleDetail];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
    
}
@end
