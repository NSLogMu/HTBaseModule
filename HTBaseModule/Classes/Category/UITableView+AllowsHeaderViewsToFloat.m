//
//  UITableView+AllowsHeaderViewsToFloat.m
//  HTBase
//
//  Created by mc on 2021/4/25.
//

#import "UITableView+AllowsHeaderViewsToFloat.h"
#import <objc/runtime.h>

static const void *canHeaderViewToFloatKey = &canHeaderViewToFloatKey;
static const void *canFooterViewToFloatKey = &canFooterViewToFloatKey;

@implementation UITableView (AllowsHeaderViewsToFloat)

- (BOOL)allowsHeaderViewsToFloat
{
    return self.canHeaderViewToFloat;
}

- (BOOL)allowsFooterViewToFloat
{
    return self.canFooterViewToFloat;
}

- (BOOL)canHeaderViewToFloat
{
    return [objc_getAssociatedObject(self, canHeaderViewToFloatKey) boolValue];
}

- (void)setCanHeaderViewToFloat:(BOOL)canHeaderViewToFloat
{
    objc_setAssociatedObject(self, canHeaderViewToFloatKey, [NSNumber numberWithBool:canHeaderViewToFloat], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)canFooterViewToFloat
{
    return [objc_getAssociatedObject(self, canFooterViewToFloatKey) boolValue];
}

- (void)setCanFooterViewToFloat:(BOOL)canFooterViewToFloat
{
    objc_setAssociatedObject(self, canFooterViewToFloatKey, [NSNumber numberWithBool:canFooterViewToFloat], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
