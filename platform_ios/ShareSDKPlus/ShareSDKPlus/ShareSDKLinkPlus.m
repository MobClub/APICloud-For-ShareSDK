//
//  ShareSDKLinkPlus.m
//  ShareSDKPlus
//
//  Created by maxl on 2020/3/26.
//  Copyright © 2020 Mob. All rights reserved.
//

#import "ShareSDKLinkPlus.h"
#import "NSObject+SSDKHBModel.h"
#import "ShareSDKLinkRestoreManager.h"
static NSString *const shareSDKLinkModuleName = @"shareSDKLinkPlus";
@implementation ShareSDKLinkPlus
+ (void)onAppLaunch:(NSDictionary *)launchOptions{
    [ShareSDKLinkRestoreManager manager];
}
JS_METHOD(shareLinkSceneRestore:(UZModuleMethodContext *)context)
{
    [[ShareSDKLinkRestoreManager manager] addModule:context];
}
- (void)dispose {
    // 方法在模块销毁之前被调用
}
@end
