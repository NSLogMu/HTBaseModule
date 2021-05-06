//
//  HTAccountTool.m
//  AFNetworking
//
//  Created by mc on 2021/5/6.
//

#import "HTAccountTool.h"
#define kFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"HTAccount.data"]

@implementation HTAccountTool
single_implementation(HTAccountTool)

- (id)init{
    if (self = [super init]) {
        NSData *accountData =  [NSData dataWithContentsOfFile:kFile];
        if (@available(iOS 11.0, *)) {
            _account = [NSKeyedUnarchiver unarchivedObjectOfClass:[HTAccount class] fromData:accountData error:nil];
        } else {
            _account = [NSKeyedUnarchiver unarchiveObjectWithFile:kFile];
        }
    }
    return self;
}

#pragma mark - 保存用户数据
- (void)saveAccount:(HTAccount *)account{
    _account = account;
    if (@available(iOS 11.0, *)) {
        NSData *accountData = [NSKeyedArchiver archivedDataWithRootObject:account requiringSecureCoding:YES error:nil];
        [[NSFileManager defaultManager] createFileAtPath:kFile contents:nil attributes:nil];
        [accountData writeToFile:kFile atomically:YES];
    } else {
        [NSKeyedArchiver archiveRootObject:account toFile:kFile];
    }
}

- (BOOL)isLogin{
    if (AccountTool.account) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark - 退出app账户操作
 
- (void)logoutQSCAccount{
    [AccountTool saveAccount:nil];
    //获取归档路路径,清空沙盒
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *shahePath = [pathArray objectAtIndex:0];
    NSError *error;
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    NSArray *tmplist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:shahePath error:nil];
    for (NSString *filename in tmplist) {
//        kLog(@"沙盒文件-----%@",filename);
        if([filename rangeOfString:@"storePdf"].location !=NSNotFound || [filename rangeOfString:@"HTAccount.data"].location !=NSNotFound){
            NSString *fullpath = [shahePath stringByAppendingPathComponent:filename];
            if ([defaultManager isDeletableFileAtPath:fullpath]) {
                [defaultManager removeItemAtPath:fullpath error:&error];
            }
        }
    }
//    kLog(@"退出登录");
}


@end
