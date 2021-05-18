//
//  HTBaseButton.m
//  AFNetworking
//
//  Created by mc on 2021/5/11.
//

#import "HTBaseButton.h"

@implementation HTBaseButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    self.clipsToBounds = YES;
    [self addTarget:self action:@selector(touchDownAction:event:) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(touchCancel:) forControlEvents:UIControlEventTouchCancel];
    [self addTarget:self action:@selector(touchDragExit:) forControlEvents:UIControlEventTouchDragExit];
    return self;
}

- (instancetype)init {
    
    self = [super init];
    self.clipsToBounds = YES;
    [self addTarget:self action:@selector(touchDownAction:event:) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(touchCancel:) forControlEvents:UIControlEventTouchCancel];
    [self addTarget:self action:@selector(touchDragExit:) forControlEvents:UIControlEventTouchDragExit];
    return self;
}

#pragma mark - CallBack Event

- (void)setBlock:(void (^)(HTBaseButton *button))block {
    
    _block = block;
    [self addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - Private Event response

- (void)touchDownAction:(id)sender event:(UIEvent *)event {
    self.enabled = NO;
}

- (void)touchAction:(id)sender {
        self.enabled = YES;
        _block(self);
}

- (void)touchCancel:(id)sender {
    
    self.enabled = YES;
}
- (void)touchDragExit:(id)sender {
    
    self.enabled = YES;
}

- (void)touchDragDragInside:(id)sender {
    
    self.enabled = YES;
}
@end
