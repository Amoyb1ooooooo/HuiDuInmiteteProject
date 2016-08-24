//
//  DBUtil.h
//  HuiDuProject
//
//  Created by Amoyb1oo on 16/8/24.
//  Copyright © 2016年 Amoyb1oo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "DiscoverList.h"

@interface DBUtil : NSObject

@property (nonatomic,strong)FMDatabase *db;

- (void)createDb;

- (void)createTable;


- (void)open;

- (void)close;

- (void)add:(DiscoverList*)list;
- (void)del:(DiscoverList*)list;
- (BOOL)check:(DiscoverList*)list;

@end
