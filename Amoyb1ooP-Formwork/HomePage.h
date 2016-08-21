//
//  HomePage.h
//  HuiDuProject
//
//  Created by Amoyb1oo on 16/8/19.
//  Copyright © 2016年 Amoyb1oo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleManager.h"
#import "MyArticleTableViewCell.h"
#import "Article.h"
#import "ArticleDetailViewController.h"

@interface HomePage : UIViewController
<
UITableViewDelegate,
UITableViewDataSource,
ArticleManagerDelegate
>



@end
