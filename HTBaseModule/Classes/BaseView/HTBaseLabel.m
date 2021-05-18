//
//  HTBaseLabel.m
//  AFNetworking
//
//  Created by mc on 2021/5/11.
//

#import "HTBaseLabel.h"
#import "UIColor+HTHex.h"
#import "HTPublicDefine.h"
@implementation HTBaseLabel

- (instancetype)init {
    
    self = [super init];
    if (self) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _textInsets)];
}

// 主色调Lab
+ (instancetype)mainColorLabel {

    HTBaseLabel *lab = [[HTBaseLabel alloc] init];
    lab.textColor = [UIColor colorWithHexString:TextColor alpha:1];
    lab.font = [UIFont systemFontOfSize:14*SCALE_6];
    
    return lab;
}

// 辅助色Color
+ (instancetype)subColorLabel {
    
    HTBaseLabel *lab = [[HTBaseLabel alloc] init];
    lab.textColor = [UIColor colorWithHexString:FuColor alpha:1];
    lab.font = [UIFont systemFontOfSize:14*SCALE_6];
    
    return lab;
}

@end
