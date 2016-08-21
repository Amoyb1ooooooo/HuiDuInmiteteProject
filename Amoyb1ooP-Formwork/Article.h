//
//  Article.h
//  HuiDuProject
//
//  Created by Amoyb1oo on 16/8/19.
//  Copyright © 2016年 Amoyb1oo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject

/*
 {"id":42153,"title":"工作流系统的设计","author":"四火","shortDesc":"几年前曾经写过一点点对于缓存框架设计的体会，这大半年和工作流系统打交道颇为丰富，因此想总结一点关","url":null,"content":null,"publishTime":1471591739000}
 */

@property(nonatomic,assign)NSInteger aid;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *author;
@property(nonatomic,strong)NSString *shortDesc;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *publishTime;

@end
