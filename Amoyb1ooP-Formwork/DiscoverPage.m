//
//  DiscoverPage.m
//  HuiDuProject
//
//  Created by Amoyb1oo on 16/8/19.
//  Copyright © 2016年 Amoyb1oo. All rights reserved.
//

#import "DiscoverPage.h"
#import "DiscoverList.h"
#import "DBUtil.h"

@interface DiscoverPage ()
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIImage *ok,*cancle;
@property (nonatomic,strong)ArticleManager *manager;
@property (nonatomic,strong)DBUtil *util;

@end

@implementation DiscoverPage

- (void)viewDidLoad {
    [super viewDidLoad];
    _util = [[DBUtil alloc]  init];
    
    self.navigationItem.title = @"发现";
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 10, self.view.frame.size.width-20, self.view.frame.size.height)];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _ok = [UIImage imageNamed:@"followTopic.png"];
    _cancle = [UIImage imageNamed:@"cancleFollow.png"];
    
    _manager = [[ArticleManager alloc]init];
    _manager.delegate = self;
    [_manager getArticleCategory];
    
}

- (void)updataArticleCategory{
    [_tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _manager.articleCategoryDataSource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cid = @"cid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
    }
    
    DiscoverList *list = [_manager.articleCategoryDataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = list.name;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    // btn.layer.cornerRadius = 8;
    btn.frame = CGRectMake(50, 0, 30, 30);
    [btn setTag:indexPath.row];
    
    if ([_util check:list]) {
        [btn setImage:_cancle forState:UIControlStateNormal];
    }else{
        [btn setImage:_ok forState:UIControlStateNormal];
    }
    [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    // btn.layer.edgeAntialiasingMask = YES;
    // btn.layer.cornerRadius = 20;
    
    cell.accessoryView = btn;
    
    return cell;
}

- (IBAction)pressBtn:(UIButton*)sender{
    NSInteger tag = sender.tag;
    DiscoverList *list = [_manager.articleCategoryDataSource objectAtIndex:tag];
    
    
    UIImage *image = [sender imageForState:UIControlStateNormal];
    if (image == _ok) {
        [_util add:list];
        [sender setImage:_cancle forState:UIControlStateNormal];
    }
    if (image == _cancle){
        [_util del:list];
        [sender setImage:_ok forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
