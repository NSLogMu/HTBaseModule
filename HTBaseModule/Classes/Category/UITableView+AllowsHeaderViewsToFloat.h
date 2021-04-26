//
//  UITableView+AllowsHeaderViewsToFloat.h
//  HTBase
//
//  Created by mc on 2021/4/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
*  允许table view section header随cell一起滚动而不是再顶部悬停 private methods
*/
@interface UITableView (AllowsHeaderViewsToFloat)
@property (nonatomic,assign) BOOL canHeaderViewToFloat;//default is NO
@property (nonatomic,assign) BOOL canFooterViewToFloat;//default is NO
@end

NS_ASSUME_NONNULL_END
