//
//  HTBaseTableView.m
//  HTBaseModule
//
//  Created by mc on 2021/4/27.
//

#import "HTBaseTableView.h"
#import "UIColor+HTHex.h"
#import "Masonry.h"
#import "HTPublicDefine.h"
@implementation HTBaseTableView

+ (instancetype)tableViewPlainStyle {
    
    HTBaseTableView *_tableView = [[HTBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorColor = [UIColor colorWithHexString:@"#E6E6E6" alpha:1];
    // 设置隐藏多余的线
    _tableView.sectionFooterHeight = 0;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    return _tableView;
}

+ (instancetype)tableViewGroupedStyle {
    
    HTBaseTableView *_tableView = [[HTBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];   // 隐藏顶部多余的高度
    _tableView.backgroundColor = [UIColor clearColor];
    // 设置分割线的颜色
    _tableView.separatorColor = [UIColor colorWithHexString:@"#E6E6E6" alpha:1];
    // 设置隐藏多余的线
    _tableView.sectionFooterHeight = 0;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    return _tableView;
}

- (void)setNodata:(BOOL)hasNoData WithMessage:(NSString *)message {
    
    if (hasNoData) {
        if (_noDataView == nil) {
            _noDataView = [[UIView alloc] init];
            [self addSubview:_noDataView];
            [_noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.left.mas_equalTo(0);
                make.width.mas_equalTo(self.mas_width);
                make.height.mas_equalTo(self.mas_height);
            }];
            
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img-record"]];
            imageView.contentMode = UIViewContentModeCenter;
            [_noDataView addSubview:imageView];
            self.imageView = imageView;
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.noDataView.mas_centerX);
                make.centerY.mas_equalTo(self.noDataView.mas_centerY).offset(-kSafeArea_Nav);
                make.width.mas_greaterThanOrEqualTo(5);
                make.height.mas_greaterThanOrEqualTo(5);
            }];
            UILabel *tipsLab = [[UILabel alloc]init];
            tipsLab.textColor = [UIColor colorWithHexString:@"#797B84" alpha:1];
            tipsLab.text = message;
            tipsLab.font = [UIFont systemFontOfSize:14*SCALE_6];
            tipsLab.textAlignment = NSTextAlignmentCenter;
            [_noDataView addSubview:tipsLab];
            [tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(20);
                make.top.mas_equalTo(imageView.mas_bottom).with.mas_offset(15);
                make.left.right.mas_equalTo(0);
            }];
            self.messageLb = tipsLab;
           
        }
        _noDataView.hidden = NO;
    }
    else {
        if (_noDataView) {
            _noDataView.hidden = YES;
        }
    }
     self.messageLb.text = message;
}


@end
