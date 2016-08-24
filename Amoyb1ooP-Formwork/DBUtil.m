//
//  DBUtil.m
//  HuiDuProject
//
//  Created by Amoyb1oo on 16/8/24.
//  Copyright © 2016年 Amoyb1oo. All rights reserved.
//

#import "DBUtil.h"


@implementation DBUtil

- (instancetype)init{
    self = [super init];
    if (self) {
        [self createDb];
        [self createTable];
        return self;
    }
    return nil;
}

- (void)createDb{
    // 创建数据库
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [array objectAtIndex:0];
    NSString *filename = [path stringByAppendingPathComponent:@"article.db"];
    _db = [FMDatabase databaseWithPath:filename];
    NSLog(@"jacyh%@",path);
}

- (void)createTable{
    NSString *sql = @" create table if not exists ArticleCategory (did integer primary key, name text)";
    [self open];
    if (_db != nil) {
    BOOL b = [_db executeUpdate:sql];
        NSLog(@"%@",b?@"success":@"defeat");
    }
    [self close];
}

- (void)open{
    if (_db != nil) {
        [_db open];
    }
}

- (void)close{
    if (_db != nil) {
        [_db close];
    }
}

- (void)add:(DiscoverList*)list{
    NSString *sql = @" insert into ArticleCategory(did,name) values(?,?) ";
    [self open];
    BOOL b = [_db executeUpdate:sql,[NSString stringWithFormat:@"%ld",list.did],list.name];
    NSLog(@"%@",b?@"follow":@"unFollow");
    [self close];
}

- (void)del:(DiscoverList*)list{
    NSString *sql = @" delete from ArticleCategory where did = ? ";
    [self open];
    BOOL b = [_db executeUpdate:sql,[NSString stringWithFormat:@"%ld",list.did]];
    NSLog(@"%@",b?@"delete":@"delete defeat");
    [self close];
}

- (BOOL)check:(DiscoverList*)list{
    NSString *sql = @" select did from ArticleCategory";
    [self open];
    FMResultSet *set = [_db executeQuery:sql];
    while ([set next]) {
        int did = [set intForColumnIndex:0];
        if (did == list.did) {
            [self close];
            return true;
        }
    }
    [self close];
    return false;
}

@end
