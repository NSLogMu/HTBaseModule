//
//  HTBaseButton.h
//  AFNetworking
//
//  Created by mc on 2021/5/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTBaseButton : UIButton
@property(nonatomic, strong) void(^block)(HTBaseButton *button);
@end

NS_ASSUME_NONNULL_END
