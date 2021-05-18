//
//  HTBaseTableViewCell.h
//  AFNetworking
//
//  Created by mc on 2021/5/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTBaseTableViewCell : UITableViewCell
// 初始化Cell
+ (instancetype)tableCellWithTableView:(UITableView *)tableView
                           withReuesID:(NSString *)reuesId;
@end

NS_ASSUME_NONNULL_END
