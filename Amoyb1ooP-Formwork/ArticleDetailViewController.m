//
//  ArticleDetailViewController.m
//  HuiDuProject
//
//  Created by Amoyb1oo on 16/8/21.
//  Copyright © 2016年 Amoyb1oo. All rights reserved.
//

#import "ArticleDetailViewController.h"
@interface ArticleDetailViewController ()

@property (nonatomic,strong)UILabel *authorLabel,*publishTime,*titleLabel;
@property (nonatomic,strong)UIWebView *webView;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)ArticleManager *articlemanager;
@property (nonatomic,assign)double labelActualSizeHeigth,webViewActualSizeHeight;
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)NSArray *categoryListDatasource;
@property (nonatomic,strong)UIImage *ok,*cancle;
@end

@implementation ArticleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutUI];
    _articlemanager = [[ArticleManager alloc]init];
    _articlemanager.delegate = self;
    [_articlemanager getArticleDetail];
    _categoryListDatasource = @[];
    _ok = [UIImage imageNamed:@"followTopic.png"];
    _cancle = [UIImage imageNamed:@"cancleFollow.png"];
    
}

- (void)updataArticleDetail{
    NSDictionary *superDic = _articlemanager.articleDetailDataSource;
    NSLog(@"%@",superDic);
    NSDictionary *dic = [superDic objectForKey:@"result"];
    
    NSDictionary *model = [superDic objectForKey:@"models"];
    _categoryListDatasource = [model objectForKey:@"categoryList"];
    [_tableView reloadData];
    
    NSString *author = [dic objectForKey:@"author"];
    NSString *content = [dic objectForKey:@"content"];
    NSString *publishTime = [dic objectForKey:@"publishTime"];
    NSString *title = [dic objectForKey:@"title"];
    // NSString *shortDesc = [dic objectForKey:@"shortDesc"];
    _authorLabel.text = author;
    _titleLabel.text = title;
    
    // 更新title的高度 按照实际内容
    UIFont *font = [UIFont boldSystemFontOfSize:20];
    _titleLabel.font = font;
    _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [_titleLabel setNumberOfLines:0];
    CGSize size = CGSizeMake(self.view.frame.size.width, MAXFLOAT);
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGSize actualSize = [title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic1 context:nil].size;
    self.labelActualSizeHeigth = actualSize.height;
    self.titleLabel.frame = CGRectMake(5, 35, actualSize.width, actualSize.height);
    
    
    NSDate *date = [NSDate date];
    [date dateByAddingTimeInterval:[publishTime doubleValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateStyle = NSDateFormatterLongStyle;
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    _publishTime.text = [formatter stringFromDate:date];;
    
   // 更新webView的高度
    _webView.frame = CGRectMake(10, actualSize.height+90, self.view.frame.size.width-20, self.view.frame.size.height);
    
    
    [_webView loadHTMLString:content baseURL:nil];
    
    
}

- (void)layoutUI{
    _authorLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
    _publishTime = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, 150, 36)];
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, self.view.frame.size.width-10, 50)];
    
    [self.view addSubview:_authorLabel];
    [self.view addSubview:_publishTime];
    [self.view addSubview:_titleLabel];
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(10, 70, self.view.frame.size.width-20, self.view.frame.size.height*2)];
    [_webView loadHTMLString:@"content" baseURL:nil];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 150, self.view.frame.size.width-20, self.view.frame.size.height-280)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    // scrollView
    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    CGSize size = CGSizeMake(self.view.frame.size.width, 50+_labelActualSizeHeigth+_webViewActualSizeHeight+_tableView.frame.size.height);
    _scrollView.contentSize = size;
    
    [_scrollView addSubview:_authorLabel];
    [_scrollView addSubview:_publishTime];
    [_scrollView addSubview:_titleLabel];
    [_scrollView addSubview:_webView];
    [_scrollView addSubview:_tableView];
    [self.view addSubview:self.scrollView];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    _webView.scrollView.scrollEnabled = NO;
    CGRect frame = _webView.frame;
    
    frame.size.width = 280;
    frame.size.height = 1;
    _webView.frame = frame; // Set webView's frame,forcing the layout of it's embedded scrollView with current Frame's constraints (width set above);
    
    CGFloat webViewHeight = _webView.scrollView.contentSize.height; // get the corresponding height from the webView's embedded scrollView;
    self.webViewActualSizeHeight = webViewHeight;
    
    _webView.frame = CGRectMake(10, self.labelActualSizeHeigth+60, self.view.frame.size.width-20, webViewHeight);
    
    _tableView.frame = CGRectMake(10, webViewHeight+_labelActualSizeHeigth, self.view.frame.size.width-20, self.view.frame.size.height-280);
    
    CGSize size = CGSizeMake(self.view.frame.size.width, _authorLabel.frame.size.height+_titleLabel.frame.size.height+_webView.frame.size.height+50*_categoryListDatasource.count);
    _scrollView.contentSize = size;
    /*
    _tableView.frame = CGRectMake(10, 50+self.labelActualSizeHeigth+self.webViewActualSizeHeight, self.view.frame.size.width, 60*_tableViewDataSource.count+40);
    */
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _categoryListDatasource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
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
    
    NSDictionary *dic = [_categoryListDatasource objectAtIndex:indexPath.row];
    cell.textLabel.text = [dic objectForKey:@"name"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 30, 30);
    
    [btn setImage:_ok forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.accessoryView = btn;
    
    return cell;
}

- (void)pressBtn:(UIButton*)btn{
    UIImage *image = [btn imageForState:UIControlStateNormal];
    if (image == _ok) {
        [btn setImage:_cancle forState:UIControlStateNormal];
    }
    if (image == _cancle) {
        [btn setImage:_ok forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
