//
//  HTBaseTableViewCell.m
//  AFNetworking
//
//  Created by mc on 2021/5/12.
//

#import "HTBaseTableViewCell.h"

@implementation HTBaseTableViewCell

+ (instancetype)tableCellWithTableView:(UITableView *)tableView
                           withReuesID:(NSString *)reuesId {
    id cell = [tableView dequeueReusableCellWithIdentifier:reuesId];
    if (cell == nil) {
        cell = [[NSClassFromString([NSString stringWithUTF8String:object_getClassName(self)]) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuesId];
        if ([cell isKindOfClass:[UITableViewCell class]]) {
            UITableViewCell *viewCell = (UITableViewCell *)cell;
            viewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
