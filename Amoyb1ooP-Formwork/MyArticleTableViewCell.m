//
//  MyArticleTableViewCell.m
//  HuiDuProject
//
//  Created by Amoyb1oo on 16/8/19.
//  Copyright © 2016年 Amoyb1oo. All rights reserved.
//

#import "MyArticleTableViewCell.h"

@implementation MyArticleTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self layoutUI];
        return self;
    }
    return nil;
    
}

- (void)layoutUI{
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, 36)];
    _titleLabel.font = [UIFont boldSystemFontOfSize:15];
    _authorLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 22, 100, 36)];
    _authorLabel.font = [UIFont systemFontOfSize:12];
    _publishLabe = [[UILabel alloc]initWithFrame:CGRectMake(100, 22, 100, 36)];
    _publishLabe.font = [UIFont systemFontOfSize:12];
    _shortDescLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 43, self.frame.size.width+50, 36)];
    _shortDescLabel.font = [UIFont systemFontOfSize:12];
    
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_authorLabel];
    [self.contentView addSubview:_publishLabe];
    [self.contentView addSubview:_shortDescLabel];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
