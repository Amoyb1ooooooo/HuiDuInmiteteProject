//
//  DiscoverPage.m
//  HuiDuProject
//
//  Created by Amoyb1oo on 16/8/19.
//  Copyright © 2016年 Amoyb1oo. All rights reserved.
//

#import "DiscoverPage.h"
#import "DiscoverList.h"

@interface DiscoverPage ()
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)UIImage *ok,*cancle;

@end

@implementation DiscoverPage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发现";
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 10, self.view.frame.size.width-20, self.view.frame.size.height)];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    
    DiscoverList *d1 = [[DiscoverList alloc]init];
    d1.did = @"1";
    d1.name = @"d1";

    DiscoverList *d2 = [[DiscoverList alloc]init];
    d2.did = @"2";
    d2.name = @"d2";

    DiscoverList *d3 = [[DiscoverList alloc]init];
    d3.did = @"3";
    d3.name = @"d4";
    
    DiscoverList *d4 = [[DiscoverList alloc]init];
    d4.did = @"4";
    d4.name = @"d4";
    
    DiscoverList *d5 = [[DiscoverList alloc]init];
    d5.did = @"5";
    d5.name = @"d5";
    
    
    
    _dataSource = [[NSMutableArray alloc]initWithObjects:d1,d2,d3,d4,d5, nil];
    [self.view addSubview:_tableView];
    _ok = [UIImage imageNamed:@"followTopic.png"];
    _cancle = [UIImage imageNamed:@"cancleFollow.png"];
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
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
     DiscoverList *d = [_dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = d.name;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    // btn.layer.cornerRadius = 8;
    btn.frame = CGRectMake(50, 0, 30, 30);
    [btn setImage:_ok forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(guanzhu:) forControlEvents:UIControlEventTouchUpInside];
    
    // btn.layer.edgeAntialiasingMask = YES;
    // btn.layer.cornerRadius = 20;
    
    cell.accessoryView = btn;
    
    return cell;
}

- (IBAction)guanzhu:(UIButton*)sender{
    UIImage *image = [sender imageForState:UIControlStateNormal];
    if (image == _ok) {
        [sender setImage:_cancle forState:UIControlStateNormal];
    }
    if (image == _cancle){
        [sender setImage:_ok forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
