//
//  HomePage.m
//  HuiDuProject
//
//  Created by Amoyb1oo on 16/8/19.
//  Copyright © 2016年 Amoyb1oo. All rights reserved.
//

#import "HomePage.h"

@interface HomePage ()

@property(nonatomic,strong)UITableView *tableView;
// @property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)ArticleManager *articleManager;

@end

@implementation HomePage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    _articleManager = [[ArticleManager alloc]init];
    [_articleManager getArticleList];
    _articleManager.delegate = self;
    // self.view.backgroundColor = [UIColor colorWithRed:239 green:239 blue:244 alpha:1];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake
                  (5, -30, self.view.frame.size.width-10, self.view.frame.size.height)
                  style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    //_dataSource = [NSMutableArray arrayWithCapacity:5];
    
}

- (void)updataArticleList{
    [_tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _articleManager.articleListDataSource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cid = @"cid";
    MyArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
    if (cell == nil) {
        cell = [[MyArticleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
    }
    
    Article *a = [_articleManager.articleListDataSource objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = a.title;
    cell.authorLabel.text = a.author;
    
    NSDate *date = [NSDate date];
    [date dateByAddingTimeInterval:[a.publishTime doubleValue]];
    // NSLog(@"%@",date);
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    // formatter.timeStyle = NSDateFormatterMediumStyle;
    formatter.dateStyle = NSDateFormatterLongStyle;
    formatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    
    cell.publishLabe.text = [formatter stringFromDate:date];
    cell.shortDescLabel.text = a.shortDesc;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ArticleDetailViewController *ADC = [self.storyboard instantiateViewControllerWithIdentifier:@"ArticleDetailViewController"];
    [self.navigationController pushViewController:ADC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
