//
//  HTBaseTableView.h
//  HTBaseModule
//
//  Created by mc on 2021/4/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTBaseTableView : UITableView
@property (nonatomic, strong) UIView *noDataView;
@property (nonatomic, strong) UILabel *messageLb;
@property (nonatomic, strong)UIImageView *imageView;

+ (instancetype)tableViewPlainStyle;
+ (instancetype)tableViewGroupedStyle;
- (void)setNodata:(BOOL)hasNoData WithMessage:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
