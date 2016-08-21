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
@property (nonatomic,assign)double labelActualSizeHeigth;
@end

@implementation ArticleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutUI];
    _articlemanager = [[ArticleManager alloc]init];
    _articlemanager.delegate = self;
    [_articlemanager getArticleDetail];
    
    // Do any additional setup after loading the view.
}

- (void)updataArticleDetail{
    NSDictionary *superDic = _articlemanager.articleDetailDataSource;
    NSLog(@"%@",superDic);
    NSDictionary *dic = [superDic objectForKey:@"result"];
    
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
    self.titleLabel.frame = CGRectMake(5, 85, actualSize.width, actualSize.height);
    
    
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
    _authorLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 100, 30)];
    _publishTime = [[UILabel alloc]initWithFrame:CGRectMake(120, 60, 150, 36)];
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, self.view.frame.size.width-10, 50)];
    
    [self.view addSubview:_authorLabel];
    [self.view addSubview:_publishTime];
    [self.view addSubview:_titleLabel];
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(10, 120, self.view.frame.size.width-20, self.view.frame.size.height*2)];
    [_webView loadHTMLString:@"content" baseURL:nil];
    [self.view addSubview:_webView];
    
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
