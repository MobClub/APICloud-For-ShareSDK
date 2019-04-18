//  ShareSDKPlusExtend.m
//  ShareSDKPlusExtend
//
//  Created by wkx on 2019/4/11.
//  Copyright © 2019年 Mob. All rights reserved.
//

#import "ShareSDKPlusExtend.h"

@implementation ShareSDKPlusExtend

#pragma mark - Override
+ (void)onAppLaunch:(NSDictionary *)launchOptions {
    // 方法在应用启动时被调用
}

- (id)initWithUZWebView:(UZWebView *)webView {
    if (self = [super initWithUZWebView:webView]) {
        // 初始化方法
    }
    return self;
}

- (void)dispose {
    // 方法在模块销毁之前被调用
}
@end
