//
//  NSObject+PLNetworkingMethods.h
//  ElinePrintSDK
//
//  Created by PENGL on 19/10/16.
//  Copyright © 2016年 Eline. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PLNetworkingMethods)

// 空值处理
- (id)PL_defaultValue:(id)defaultData;
- (BOOL)PL_isEmptyObject;

@end
