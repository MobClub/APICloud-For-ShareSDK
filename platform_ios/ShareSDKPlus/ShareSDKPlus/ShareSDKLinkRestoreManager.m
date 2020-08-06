//
//  ShareSDKLinkRestoreManager.m
//  ShareSDKPlus
//
//  Created by maxl on 2020/3/26.
//  Copyright © 2020 Mob. All rights reserved.
//

#import "ShareSDKLinkRestoreManager.h"
#import <ShareSDKExtension/ShareSDK+Extension.h>
#import "UZModule.h"
#import "NSObject+SSDKHBModel.h"
@interface ShareSDKLinkRestoreManager ()<ISSERestoreSceneDelegate>

@property (nonatomic, strong) UZModuleMethodContext *context;

@property (nonatomic, strong) NSDictionary *preRestoreData;


@end
@implementation ShareSDKLinkRestoreManager

+ (ShareSDKLinkRestoreManager *)manager{
    static ShareSDKLinkRestoreManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [ShareSDKLinkRestoreManager new];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [ShareSDK setRestoreSceneDelegate:self];
    }
    return self;
}

- (void)addModule:(id)module{
    _context = module;
    if (self.preRestoreData) {
        [self.context callbackWithRet:_preRestoreData[@"success"] err:_preRestoreData[@"error"] delete:NO];
        self.preRestoreData = nil;
    }
}

- (void)ISSEWillRestoreScene:(SSERestoreScene *)scene error:(NSError *)error{
    BOOL isSuccess = YES;
    NSDictionary *ret = nil;
    NSDictionary *errorInfo = nil;
    if (scene) {
        isSuccess = YES;
        ret = scene.ssdk_hb_modelToJSONObject;
    }

    if (error) {
        errorInfo = error.userInfo.ssdk_hb_modelToJSONObject;
    }
    if (self.context) {
        [self.context callbackWithRet:ret err:errorInfo delete:NO];
    }else{
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic [@"error"] = errorInfo;
        dic [@"success"] = ret;
        self.preRestoreData = dic.copy;
    }
}

@end
