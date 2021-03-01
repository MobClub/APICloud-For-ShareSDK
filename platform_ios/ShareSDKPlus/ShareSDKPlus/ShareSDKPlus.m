//  ShareSDKPlus.m
//  ShareSDKPlus
//
//  Created by wkx on 2019/4/11.
//  Copyright © 2019年 Mob. All rights reserved.
//

#import "ShareSDKPlus.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import <MOBFoundation/MOBFoundation.h>
#import "UZAppDelegate.h"
#import <objc/message.h>
#import <AuthenticationServices/AuthenticationServices.h>
#import <ShareSDKExtension/ShareSDK+Extension.h>
static NSString *const shareSDKModuleName = @"shareSDKPlus";

@interface ShareSDKPlus ()

@property(nonatomic, strong)UIView *refView;

@end

@implementation ShareSDKPlus

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL sel = sel_registerName("addChannelWithSdkName:channel:");
        Method method = class_getClassMethod([MobSDK class],sel) ;
        if (method && method_getImplementation(method) != _objc_msgForward) {
        ((void (*)(id, SEL,id,id))objc_msgSend)([MobSDK class],sel,@"SHARESDK",@"5");
        }
    });
}

#pragma mark - Override
+ (void)onAppLaunch:(NSDictionary *)launchOptions {
    // 方法在应用启动时被调用
    NSDictionary *config = [[UZAppDelegate appDelegate] getFeatureByName:shareSDKModuleName];
    NSString *MOBAppKey = config[@"MOBAppKey"];
    NSString *MOBAppSecret = config[@"MOBAppSecret"];
    if ([MOBAppKey length] > 0 && [MOBAppSecret length] > 0)
    {
        [MobSDK registerAppKey:MOBAppKey appSecret:MOBAppSecret];
    }
    
    [self setupPlatformConfigWithParams:config];
    
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


+ (void)setupPlatformConfigWithParams:(NSDictionary *)params
{
    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
        
        // config.xml 读取
        
        if (params[@"SinaWei_AppKey"] && params[@"SinaWei_AppSecret"] && params[@"SinaWei_RedirectUri"] && params[@"SinaWei_AppUniversalLink"])
        {
            [platformsRegister setupSinaWeiboWithAppkey:params[@"SinaWei_AppKey"] appSecret:params[@"SinaWei_AppSecret"] redirectUrl:params[@"SinaWei_RedirectUri"] universalLink:params[@"SinaWei_AppUniversalLink"]];
        }
        
        if (params[@"QQ_AppKey"] && params[@"QQ_AppSecret"])
        {
            [platformsRegister setupQQWithAppId:params[@"QQ_AppKey"] appkey:params[@"QQ_AppSecret"] enableUniversalLink:YES universalLink:nil];
        }
        
        if (params[@"Wechat_AppKey"] && params[@"Wechat_AppSecret"] && params[@"Wechat_AppUniversalLink"])
        {
            [platformsRegister setupWeChatWithAppId:params[@"Wechat_AppKey"] appSecret:params[@"Wechat_AppSecret"] universalLink:params[@"Wechat_AppUniversalLink"]];
        }
        
        if (params[@"Douyin_AppKey"] && params[@"Douyin_AppSecret"])
        {
            [platformsRegister setupDouyinByAppKey:params[@"Douyin_AppKey"] appSecret:params[@"Douyin_AppSecret"]];
        }
        
        if (params[@"Facebook_AppKey"] && params[@"Facebook_AppSecret"] && params[@"Facebook_DisplayName"])
        {
            [platformsRegister setupFacebookWithAppkey:params[@"Facebook_AppKey"] appSecret:params[@"Facebook_AppSecret"] displayName:params[@"Facebook_DisplayName"]];
        }
        
        if (params[@"Twitter_AppKey"] && params[@"Twitter_AppSecret"] && params[@"Twitter_RedirectUri"])
        {
            [platformsRegister setupTwitterWithKey:params[@"Twitter_AppKey"] secret:params[@"Twitter_AppSecret"] redirectUrl:params[@"Twitter_RedirectUri"]];
        }
        
        if (params[@"AliPaySocial_AppKey"])
        {
            [platformsRegister setupAliSocialWithAppId:params[@"AliPaySocial_AppKey"]];
        }
        
        if (params[@"DingTalk_AppKey"])
        {
            [platformsRegister setupDingTalkWithAppId:params[@"DingTalk_AppKey"]];
        }
        
        if (params[@"YinXiang_AppKey"] && params[@"YinXiang_AppSecret"])
        {
            [platformsRegister setupEvernoteByConsumerKey:params[@"YinXiang_AppKey"] consumerSecret:params[@"YinXiang_AppSecret"] sandbox:params[@"YinXiang_Sandbox"]?[params[@"YinXiang_Sandbox"] integerValue]:1];
        }
        
        if (params[@"YouDaoNote_AppKey"] && params[@"YouDaoNote_AppSecret"] && params[@"YouDaoNote_RedirectUri"])
        {
            [platformsRegister setupYouDaoNoteWithConsumerKey:params[@"YouDaoNote_AppKey"] consumerSecret:params[@"YouDaoNote_AppSecret"] oauthCallback:params[@"YouDaoNote_RedirectUri"]];
        }
        
        if (params[@"Mingdao_AppKey"] && params[@"Mingdao_AppSecret"] && params[@"Mingdao_RedirectUri"])
        {
            [platformsRegister setupMingDaoByAppKey:params[@"Mingdao_AppKey"] appSecret:params[@"Mingdao_AppSecret"] redirectUrl:params[@"Mingdao_RedirectUri"]];
        }
        
        if (params[@"Kaixin_AppKey"] && params[@"Kaixin_AppSecret"] && params[@"Kaixin_RedirectUri"])
        {
            [platformsRegister setupKaiXinByApiKey:params[@"Kaixin_AppKey"] secretKey:params[@"Kaixin_AppSecret"] redirectUrl:params[@"Kaixin_RedirectUri"]];
        }
        
        if (params[@"YiXin_AppKey"] && params[@"YiXin_AppSecret"] && params[@"YiXin_RedirectUri"])
        {
            [platformsRegister setupYiXinByAppId:params[@"YiXin_AppKey"] appSecret:params[@"YiXin_AppSecret"] redirectUrl:params[@"YiXin_RedirectUri"]];
        }
        
        if (params[@"Instagram_AppKey"] && params[@"Instagram_AppSecret"] && params[@"Instagram_RedirectUri"])
        {
            [platformsRegister setupInstagramWithClientId:params[@"Instagram_AppKey"] clientSecret:params[@"Instagram_AppSecret"] redirectUrl:params[@"Instagram_RedirectUri"]];
        }
        
        [platformsRegister setupLineAuthType:params[@"Line_AuthType"]?[params[@"Line_AuthType"] integerValue]:2];
        
        
        if (params[@"Google_AppKey"] && params[@"Google_AppSecret"] && params[@"Google_RedirectUri"])
        {
            [platformsRegister setupGooglePlusByClientID:params[@"Google_AppKey"] clientSecret:params[@"Google_AppSecret"] redirectUrl:params[@"Google_RedirectUri"]];
        }
        
        if (params[@"Kakao_AppKey"] && params[@"Kakao_ApiKey"] && params[@"Kakao_RedirectUri"])
        {
            [platformsRegister setupKaKaoWithAppkey:params[@"Kakao_AppKey"] restApiKey:params[@"Kakao_ApiKey"] redirectUrl:params[@"Kakao_RedirectUri"]];
        }
        
        if (params[@"YouTube_AppKey"] && params[@"YouTube_AppSecret"] && params[@"YouTube_RedirectUri"])
        {
            [platformsRegister setupYouTubeWithClientId:params[@"YouTube_AppKey"] clientSecret:params[@"YouTube_AppSecret"] redirectUrl:params[@"YouTube_RedirectUri"]];
        }
        
        if (params[@"Flickr_AppKey"] && params[@"Flickr_AppSecret"])
        {
            [platformsRegister setupFlickrWithApiKey:params[@"Flickr_AppKey"] apiSecret:params[@"Flickr_AppSecret"]];
        }
        
        if (params[@"Dropbox_AppKey"] && params[@"Dropbox_AppSecret"] && params[@"Dropbox_RedirectUri"])
        {
            [platformsRegister setupDropboxWithAppKey:params[@"Dropbox_AppKey"] appSecret:params[@"Dropbox_AppSecret"] redirectUrl:params[@"Dropbox_RedirectUri"]];
        }
        
        if (params[@"Evernote_AppKey"] && params[@"Evernote_AppSecret"])
        {
            [platformsRegister setupEvernoteByConsumerKey:params[@"Evernote_AppKey"] consumerSecret:params[@"Evernote_AppSecret"] sandbox:params[@"Evernote_Sandbox"]?[params[@"Evernote_Sandbox"] integerValue]:1];
        }
        
        if (params[@"Pinterest_AppKey"])
        {
            [platformsRegister setupPinterestByClientId:params[@"Pinterest_AppKey"]];
        }
        
        if (params[@"Pocket_AppKey"] && params[@"Pocket_RedirectUri"])
        {
            [platformsRegister setupPocketWithConsumerKey:params[@"Pocket_AppKey"] redirectUrl:params[@"Pocket_RedirectUri"]];
        }

        if (params[@"LinkedIn_AppKey"] && params[@"LinkedIn_AppSecret"] && params[@"LinkedIn_RedirectUri"])
        {
             [platformsRegister setupLinkedInByApiKey:params[@"LinkedIn_AppKey"] secretKey:params[@"LinkedIn_AppSecret"] redirectUrl:params[@"LinkedIn_RedirectUri"]];
        }
       
        if (params[@"VKontakte_AppKey"] && params[@"VKontakte_AppSecret"])
        {
            [platformsRegister setupVKontakteWithApplicationId:params[@"VKontakte_AppKey"] secretKey:params[@"VKontakte_AppSecret"] authType:params[@"VKontakte_AuthType"]?[params[@"VKontakte_AuthType"] integerValue]:2];
        }
        
        if (params[@"Instapaper_AppKey"] && params[@"Instapaper_AppSecret"])
        {
            [platformsRegister setupInstapaperWithConsumerKey:params[@"Instapaper_AppKey"] consumerSecret:params[@"Instapaper_AppSecret"]];
        }
        
        if (params[@"Tumblr_AppKey"] && params[@"Tumblr_AppSecret"] && params[@"Tumblr_RedirectUri"])
        {
            [platformsRegister setupTumblrByConsumerKey:params[@"Tumblr_AppKey"] consumerSecret:params[@"Tumblr_AppSecret"] redirectUrl:params[@"Tumblr_RedirectUri"]];
        }

        [platformsRegister setupSMSOpenCountryList:params[@"SMS_CountryList"]?[params[@"SMS_CountryList"] integerValue]:0];
        
        if (params[@"Telegram_BotToken"] && params[@"Telegram_BotDomain"])
        {
            [platformsRegister setupTelegramByBotToken:params[@"Telegram_BotToken"] botDomain:params[@"Telegram_BotDomain"]];
        }
        
        if (params[@"Reddit_AppKey"] && params[@"Reddit_RedirectUri"])
        {
            [platformsRegister setupRedditByAppKey:params[@"Reddit_AppKey"] redirectUri:params[@"Reddit_RedirectUri"]];
        }
        
        
        
        
        // key.xml 读取
        UZAppDelegate *app = [UZAppDelegate appDelegate];
        if ([app securityValueForKey:@"shareSDKPlus_SinaWei_AppKey"] && [app securityValueForKey:@"shareSDKPlus_SinaWei_AppSecret"] && [app securityValueForKey:@"shareSDKPlus_SinaWei_RedirectUri"] && [app securityValueForKey:@"shareSDKPlus_SinaWei_AppUniversalLink"])
        {
            [platformsRegister setupSinaWeiboWithAppkey:[app securityValueForKey:@"shareSDKPlus_SinaWei_AppKey"] appSecret:[app securityValueForKey:@"shareSDKPlus_SinaWei_AppSecret"] redirectUrl:[app securityValueForKey:@"shareSDKPlus_SinaWei_RedirectUri"] universalLink:[app securityValueForKey:@"shareSDKPlus_SinaWei_AppUniversalLink"]];
        }
        
        if ([app securityValueForKey:@"shareSDKPlus_QQ_AppKey"] && [app securityValueForKey:@"shareSDKPlus_QQ_AppSecret"])
        {
            [platformsRegister setupQQWithAppId:[app securityValueForKey:@"shareSDKPlus_QQ_AppKey"] appkey:[app securityValueForKey:@"shareSDKPlus_QQ_AppSecret"]enableUniversalLink:YES universalLink:nil];
        }
        
        if ([app securityValueForKey:@"shareSDKPlus_Wechat_AppKey"] && [app securityValueForKey:@"shareSDKPlus_Wechat_AppSecret"] && [app securityValueForKey:@"shareSDKPlus_Wechat_AppUniversalLink"])
        {
            [platformsRegister setupWeChatWithAppId:[app securityValueForKey:@"shareSDKPlus_Wechat_AppKey"] appSecret:[app securityValueForKey:@"shareSDKPlus_Wechat_AppSecret"] universalLink:[app securityValueForKey:@"shareSDKPlus_Wechat_AppUniversalLink"]];
        }
        
        if ([app securityValueForKey:@"shareSDKPlus_Douyin_AppKey"] && [app securityValueForKey:@"shareSDKPlus_Douyin_AppSecret"])
        {
            [platformsRegister setupDouyinByAppKey:[app securityValueForKey:@"shareSDKPlus_Douyin_AppKey"] appSecret:[app securityValueForKey:@"shareSDKPlus_Douyin_AppSecret"]];
        }
        
        if ([app securityValueForKey:@"shareSDKPlus_Facebook_AppKey"] && [app securityValueForKey:@"shareSDKPlus_Facebook_AppSecret"] && [app securityValueForKey:@"shareSDKPlus_Facebook_DisplayName"])
        {
            [platformsRegister setupFacebookWithAppkey:[app securityValueForKey:@"shareSDKPlus_Facebook_AppKey"] appSecret:[app securityValueForKey:@"shareSDKPlus_Facebook_AppSecret"] displayName:[app securityValueForKey:@"shareSDKPlus_Facebook_DisplayName"]];
        }
        
        if ([app securityValueForKey:@"shareSDKPlus_Twitter_AppKey"] && [app securityValueForKey:@"shareSDKPlus_Twitter_AppSecret"] && [app securityValueForKey:@"shareSDKPlus_Twitter_RedirectUri"])
        {
            [platformsRegister setupTwitterWithKey:[app securityValueForKey:@"shareSDKPlus_Twitter_AppKey"] secret:[app securityValueForKey:@"shareSDKPlus_Twitter_AppSecret"] redirectUrl:[app securityValueForKey:@"shareSDKPlus_Twitter_RedirectUri"]];
        }
        
        if ([app securityValueForKey:@"shareSDKPlus_AliPaySocial_AppKey"])
        {
            [platformsRegister setupAliSocialWithAppId:[app securityValueForKey:@"shareSDKPlus_AliPaySocial_AppKey"]];
        }
        
        if ([app securityValueForKey:@"shareSDKPlus_DingTalk_AppKey"])
        {
            [platformsRegister setupDingTalkWithAppId:[app securityValueForKey:@"shareSDKPlus_DingTalk_AppKey"]];
        }
        
        if ([app securityValueForKey:@"shareSDKPlus_YinXiang_AppKey"] && [app securityValueForKey:@"shareSDKPlus_YinXiang_AppSecret"])
        {
            [platformsRegister setupEvernoteByConsumerKey:[app securityValueForKey:@"shareSDKPlus_YinXiang_AppKey"] consumerSecret:[app securityValueForKey:@"shareSDKPlus_YinXiang_AppSecret"] sandbox:[app securityValueForKey:@"shareSDKPlus_YinXiang_Sandbox"]?[[app securityValueForKey:@"shareSDKPlus_YinXiang_Sandbox"] integerValue]:1];
        }
        
        if ([app securityValueForKey:@"shareSDKPlus_YouDaoNote_AppKey"] && [app securityValueForKey:@"shareSDKPlus_YouDaoNote_AppSecret"] && [app securityValueForKey:@"shareSDKPlus_YouDaoNote_RedirectUri"])
        {
            [platformsRegister setupYouDaoNoteWithConsumerKey:[app securityValueForKey:@"shareSDKPlus_YouDaoNote_AppKey"] consumerSecret:[app securityValueForKey:@"shareSDKPlus_YouDaoNote_AppSecret"] oauthCallback:[app securityValueForKey:@"shareSDKPlus_YouDaoNote_RedirectUri"]];
        }
        
        if ([app securityValueForKey:@"shareSDKPlus_Mingdao_AppKey"] && [app securityValueForKey:@"shareSDKPlus_Mingdao_AppSecret"] && [app securityValueForKey:@"shareSDKPlus_Mingdao_RedirectUri"])
        {
            [platformsRegister setupMingDaoByAppKey:[app securityValueForKey:@"shareSDKPlus_Mingdao_AppKey"] appSecret:[app securityValueForKey:@"shareSDKPlus_Mingdao_AppSecret"] redirectUrl:[app securityValueForKey:@"shareSDKPlus_Mingdao_RedirectUri"]];
        }
        
        if ([app securityValueForKey:@"shareSDKPlus_Kaixin_AppKey"] && [app securityValueForKey:@"shareSDKPlus_Kaixin_AppSecret"] && [app securityValueForKey:@"shareSDKPlus_Kaixin_RedirectUri"])
        {
            [platformsRegister setupKaiXinByApiKey:[app securityValueForKey:@"shareSDKPlus_Kaixin_AppKey"] secretKey:[app securityValueForKey:@"shareSDKPlus_Kaixin_AppSecret"] redirectUrl:[app securityValueForKey:@"shareSDKPlus_Kaixin_RedirectUri"]];
        }
        
        if ([app securityValueForKey:@"shareSDKPlus_YiXin_AppKey"] && [app securityValueForKey:@"shareSDKPlus_YiXin_AppSecret"] && [app securityValueForKey:@"shareSDKPlus_YiXin_RedirectUri"])
        {
            [platformsRegister setupYiXinByAppId:[app securityValueForKey:@"shareSDKPlus_YiXin_AppKey"] appSecret:[app securityValueForKey:@"shareSDKPlus_YiXin_AppSecret"] redirectUrl:[app securityValueForKey:@"shareSDKPlus_YiXin_RedirectUri"]];
        }
        
        if ([app securityValueForKey:@"shareSDKPlus_Instagram_AppKey"] && [app securityValueForKey:@"shareSDKPlus_Instagram_AppSecret"] && [app securityValueForKey:@"shareSDKPlus_Instagram_RedirectUri"])
        {
            [platformsRegister setupInstagramWithClientId:[app securityValueForKey:@"shareSDKPlus_Instagram_AppKey"] clientSecret:[app securityValueForKey:@"shareSDKPlus_Instagram_AppSecret"] redirectUrl:[app securityValueForKey:@"shareSDKPlus_Instagram_RedirectUri"]];
        }
        
        [platformsRegister setupLineAuthType:[app securityValueForKey:@"shareSDKPlus_Line_AuthType"]?[[app securityValueForKey:@"shareSDKPlus_Line_AuthType"] integerValue]:2];
        
        
        if ([app securityValueForKey:@"shareSDKPlus_Google_AppKey"] && [app securityValueForKey:@"shareSDKPlus_Google_AppSecret"] && [app securityValueForKey:@"shareSDKPlus_Google_RedirectUri"])
        {
            [platformsRegister setupGooglePlusByClientID:[app securityValueForKey:@"shareSDKPlus_Google_AppKey"] clientSecret:[app securityValueForKey:@"shareSDKPlus_Google_AppSecret"] redirectUrl:[app securityValueForKey:@"shareSDKPlus_Google_RedirectUri"]];
        }
        
        if ([app securityValueForKey:@"shareSDKPlus_Kakao_AppKey"] && [app securityValueForKey:@"shareSDKPlus_Kakao_ApiKey"] && [app securityValueForKey:@"shareSDKPlus_Kakao_RedirectUri"])
        {
            [platformsRegister setupKaKaoWithAppkey:[app securityValueForKey:@"shareSDKPlus_Kakao_AppKey"] restApiKey:[app securityValueForKey:@"shareSDKPlus_Kakao_ApiKey"] redirectUrl:[app securityValueForKey:@"shareSDKPlus_Kakao_RedirectUri"]];
        }
        
        if ([app securityValueForKey:@"shareSDKPlus_YouTube_AppKey"] && [app securityValueForKey:@"shareSDKPlus_YouTube_AppSecret"] && [app securityValueForKey:@"shareSDKPlus_YouTube_RedirectUri"])
        {
            [platformsRegister setupYouTubeWithClientId:[app securityValueForKey:@"shareSDKPlus_YouTube_AppKey"] clientSecret:[app securityValueForKey:@"shareSDKPlus_YouTube_AppSecret"] redirectUrl:[app securityValueForKey:@"shareSDKPlus_YouTube_RedirectUri"]];
        }
        
        if ([app securityValueForKey:@"shareSDKPlus_Flickr_AppKey"] && [app securityValueForKey:@"shareSDKPlus_Flickr_AppSecret"])
        {
            [platformsRegister setupFlickrWithApiKey:[app securityValueForKey:@"shareSDKPlus_Flickr_AppKey"] apiSecret:[app securityValueForKey:@"shareSDKPlus_Flickr_AppSecret"]];
        }
        
        if ([app securityValueForKey:@"shareSDKPlus_Dropbox_AppKey"] && [app securityValueForKey:@"shareSDKPlus_Dropbox_AppSecret"] && [app securityValueForKey:@"shareSDKPlus_Dropbox_RedirectUri"])
        {
            [platformsRegister setupDropboxWithAppKey:[app securityValueForKey:@"shareSDKPlus_Dropbox_AppKey"] appSecret:[app securityValueForKey:@"shareSDKPlus_Dropbox_AppSecret"] redirectUrl:[app securityValueForKey:@"shareSDKPlus_Dropbox_RedirectUri"]];
        }
        
        if ([app securityValueForKey:@"shareSDKPlus_Evernote_AppKey"] && [app securityValueForKey:@"shareSDKPlus_Evernote_AppSecret"])
        {
            [platformsRegister setupEvernoteByConsumerKey:[app securityValueForKey:@"shareSDKPlus_Evernote_AppKey"] consumerSecret:[app securityValueForKey:@"shareSDKPlus_Evernote_AppSecret"] sandbox:[app securityValueForKey:@"shareSDKPlus_Evernote_Sandbox"]?[[app securityValueForKey:@"shareSDKPlus_Evernote_Sandbox"] integerValue]:1];
        }
        
        if ([app securityValueForKey:@"shareSDKPlus_Pinterest_AppKey"])
        {
            [platformsRegister setupPinterestByClientId:[app securityValueForKey:@"shareSDKPlus_Pinterest_AppKey"]];
        }
        
        if ([app securityValueForKey:@"shareSDKPlus_Pocket_AppKey"] && [app securityValueForKey:@"shareSDKPlus_Pocket_RedirectUri"])
        {
            [platformsRegister setupPocketWithConsumerKey:[app securityValueForKey:@"shareSDKPlus_Pocket_AppKey"] redirectUrl:[app securityValueForKey:@"shareSDKPlus_Pocket_RedirectUri"]];
        }
        
        if ([app securityValueForKey:@"shareSDKPlus_LinkedIn_AppKey"] && [app securityValueForKey:@"shareSDKPlus_LinkedIn_AppSecret"] && [app securityValueForKey:@"shareSDKPlus_LinkedIn_RedirectUri"])
        {
            [platformsRegister setupLinkedInByApiKey:[app securityValueForKey:@"shareSDKPlus_LinkedIn_AppKey"] secretKey:[app securityValueForKey:@"shareSDKPlus_LinkedIn_AppSecret"] redirectUrl:[app securityValueForKey:@"shareSDKPlus_LinkedIn_RedirectUri"]];
        }
        
        if ([app securityValueForKey:@"shareSDKPlus_VKontakte_AppKey"] && [app securityValueForKey:@"shareSDKPlus_VKontakte_AppSecret"])
        {
            [platformsRegister setupVKontakteWithApplicationId:[app securityValueForKey:@"shareSDKPlus_VKontakte_AppKey"] secretKey:[app securityValueForKey:@"shareSDKPlus_VKontakte_AppSecret"] authType:[app securityValueForKey:@"shareSDKPlus_VKontakte_AuthType"]?[[app securityValueForKey:@"shareSDKPlus_VKontakte_AuthType"] integerValue]:2];
        }
        
        if ([app securityValueForKey:@"shareSDKPlus_Instapaper_AppKey"] && [app securityValueForKey:@"shareSDKPlus_Instapaper_AppSecret"])
        {
            [platformsRegister setupInstapaperWithConsumerKey:[app securityValueForKey:@"shareSDKPlus_Instapaper_AppKey"] consumerSecret:[app securityValueForKey:@"shareSDKPlus_Instapaper_AppSecret"]];
        }
        
        if ([app securityValueForKey:@"shareSDKPlus_Tumblr_AppKey"] && [app securityValueForKey:@"shareSDKPlus_Tumblr_AppSecret"] && [app securityValueForKey:@"shareSDKPlus_Tumblr_RedirectUri"])
        {
            [platformsRegister setupTumblrByConsumerKey:[app securityValueForKey:@"shareSDKPlus_Tumblr_AppKey"] consumerSecret:[app securityValueForKey:@"shareSDKPlus_Tumblr_AppSecret"] redirectUrl:[app securityValueForKey:@"shareSDKPlus_Tumblr_RedirectUri"]];
        }
        
        [platformsRegister setupSMSOpenCountryList:[app securityValueForKey:@"shareSDKPlus_SMS_CountryList"]?[[app securityValueForKey:@"shareSDKPlus_SMS_CountryList"] integerValue]:0];
        
        if ([app securityValueForKey:@"shareSDKPlus_Telegram_BotToken"] && [app securityValueForKey:@"shareSDKPlus_Telegram_BotDomain"])
        {
            [platformsRegister setupTelegramByBotToken:[app securityValueForKey:@"shareSDKPlus_Telegram_BotToken"] botDomain:[app securityValueForKey:@"shareSDKPlus_Telegram_BotDomain"]];
        }
        
        if ([app securityValueForKey:@"shareSDKPlus_Reddit_AppKey"] && [app securityValueForKey:@"shareSDKPlus_Reddit_RedirectUri"])
        {
            [platformsRegister setupRedditByAppKey:[app securityValueForKey:@"shareSDKPlus_Reddit_AppKey"] redirectUri:[app securityValueForKey:@"shareSDKPlus_Reddit_RedirectUri"]];
        }
        
    }];
}

JS_METHOD(authorize:(UZModuleMethodContext *)context)
{
    NSDictionary *params = context.param;
    
    SSDKPlatformType type = SSDKPlatformTypeAny;
    if ([[params objectForKey:@"platform"] isKindOfClass:[NSNumber class]])
    {
        type = [[params objectForKey:@"platform"] unsignedIntegerValue];
    }
    
    NSDictionary *settings = nil;
    if ([[params objectForKey:@"settings"] isKindOfClass:[NSDictionary class]])
    {
        settings = (NSDictionary *)[params objectForKey:@"settings"];
    }
    
    [ShareSDK authorize:type settings:nil onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
             //返回
             NSMutableDictionary *responseDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                  [NSNumber numberWithInteger:state],
                                                  @"state",
                                                  user.dictionaryValue?:@{},
                                                  @"data",
                                                  nil];
             if (error)
             {
                 [responseDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                          [NSNumber numberWithInteger:[error code]],
                                          @"error_code",
                                          [error userInfo],
                                          @"error_msg",
                                          nil]
                                  forKey:@"error"];
             }
             
        [context callbackWithRet:responseDict err:nil delete:YES];
    }];
}

JS_METHOD(cancelAuthorize:(UZModuleMethodContext *)context)
{
    NSDictionary *params = context.param;
    
    SSDKPlatformType type = SSDKPlatformTypeAny;
    if ([[params objectForKey:@"platform"] isKindOfClass:[NSNumber class]])
    {
        type = [[params objectForKey:@"platform"] unsignedIntegerValue];
    }
    
    [ShareSDK cancelAuthorize:type result:nil];
    
    //返回
    NSDictionary *responseDict = @{@"state" : [NSNumber numberWithInteger:SSDKResponseStateSuccess]};
    [context callbackWithRet:responseDict err:nil delete:YES];
}

JS_METHOD(getUserInfo:(UZModuleMethodContext *)context)
{
    NSDictionary *params = context.param;
    
    SSDKPlatformType type = SSDKPlatformTypeAny;
    if ([[params objectForKey:@"platform"] isKindOfClass:[NSNumber class]])
    {
        type = [[params objectForKey:@"platform"] unsignedIntegerValue];
    }
    
    [ShareSDK getUserInfo:type
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
               //返回
               NSMutableDictionary *responseDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                    @(state),
                                                    @"state",
                                                    nil];
               if (error)
               {
                   [responseDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                            [NSNumber numberWithInteger:[error code]],
                                            @"error_code",
                                            [error userInfo],
                                            @"error_msg",
                                            nil]
                                    forKey:@"error"];
               }
               
               if ([user dictionaryValue])
               {
                   [responseDict setObject:user.dictionaryValue forKey:@"data"];
               }
               
               [context callbackWithRet:responseDict err:nil delete:YES];
    }];
}

JS_METHOD(shareContent:(UZModuleMethodContext *)context)
{
    NSDictionary *params = context.param;
    
    SSDKPlatformType type = SSDKPlatformTypeAny;
    
    if ([[params objectForKey:@"platform"] isKindOfClass:[NSNumber class]])
    {
        type = [[params objectForKey:@"platform"] unsignedIntegerValue];
    }
    
    NSMutableDictionary *content = nil;
    if ([[params objectForKey:@"shareParams"] isKindOfClass:[NSDictionary class]])
    {
        content = [self _contentWithDict:[params objectForKey:@"shareParams"]];
    }
    
    [ShareSDK share:type
         parameters:content
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         
         //返回
         NSMutableDictionary *responseDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                              [NSNumber numberWithInteger:state],
                                              @"state",
                                              nil];
         if (error)
         {
             NSLog(@"%@",error);
             [responseDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                      [NSNumber numberWithInteger:[error code]],
                                      @"error_code",
                                      [error userInfo],
                                      @"error_msg",
                                      nil]
                              forKey:@"error"];
         }
         
         if ([contentEntity rawData])
         {
             [responseDict setObject:[contentEntity rawData] forKey:@"data"];
         }
         
         [context callbackWithRet:responseDict err:nil delete:YES];
     }];
}

JS_METHOD(shareByActivityWithContent:(UZModuleMethodContext *)context)
{
    NSDictionary *params = context.param;
    
    SSDKPlatformType type = SSDKPlatformTypeAny;
    
    if ([[params objectForKey:@"platform"] isKindOfClass:[NSNumber class]])
    {
        type = [[params objectForKey:@"platform"] unsignedIntegerValue];
    }
    
    NSMutableDictionary *content = nil;
    if ([[params objectForKey:@"shareParams"] isKindOfClass:[NSDictionary class]])
    {
        content = [self _contentWithDict:[params objectForKey:@"shareParams"]];
    }
    
    [ShareSDK shareByActivityViewController:type
         parameters:content
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         
         //返回
         NSMutableDictionary *responseDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                              [NSNumber numberWithInteger:state],
                                              @"state",
                                              nil];
         if (error)
         {
             NSLog(@"%@",error);
             [responseDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                      [NSNumber numberWithInteger:[error code]],
                                      @"error_code",
                                      [error userInfo],
                                      @"error_msg",
                                      nil]
                              forKey:@"error"];
         }
         
         if ([contentEntity rawData])
         {
             [responseDict setObject:[contentEntity rawData] forKey:@"data"];
         }
         
         [context callbackWithRet:responseDict err:nil delete:YES];
     }];
}

JS_METHOD(isInstallPlatform:(UZModuleMethodContext *)context)
{
    NSDictionary *params = context.param;
    SSDKPlatformType type = SSDKPlatformTypeAny;
    
    if ([[params objectForKey:@"platform"] isKindOfClass:[NSNumber class]])
    {
        type = [[params objectForKey:@"platform"] unsignedIntegerValue];
    }
    NSMutableDictionary *responseDict = [NSMutableDictionary dictionary];
    responseDict[@"state"] = @([ShareSDK isClientInstalled:type]);
    [context callbackWithRet:responseDict err:nil delete:YES];
}

JS_METHOD(oneKeyShareContent:(UZModuleMethodContext *)context)
{
    NSDictionary *params = context.param;
    
    NSArray *types = nil;
    if ([[params objectForKey:@"platforms"] isKindOfClass:[NSArray class]])
    {
        types = [params objectForKey:@"platforms"];
    }
    
    NSMutableDictionary *content = nil;
    if ([[params objectForKey:@"shareParams"] isKindOfClass:[NSDictionary class]])
    {
        content = [self _contentWithDict:[params objectForKey:@"shareParams"]];
    }
    
    CGFloat x = 0;
    if ([[params objectForKey:@"x"] isKindOfClass:[NSNumber class]])
    {
        x = [[params objectForKey:@"x"] floatValue];
    }
    
    CGFloat y = 0;
    if ([[params objectForKey:@"y"] isKindOfClass:[NSNumber class]])
    {
        y = [[params objectForKey:@"y"] floatValue];
    }
    
//    UIViewController *vc = [MOBFViewController currentViewController];
//    if ([MOBFDevice isPad])
//    {
//        if (!_refView)
//        {
//            _refView = [[UIView alloc] initWithFrame:CGRectMake(x, y, 1, 1)];
//        }
//        else
//        {
//            _refView.frame = CGRectMake(x, y, 1, 1);
//        }
//
//        [vc.view addSubview:_refView];
//    }
    
    [ShareSDK showShareActionSheet:_refView customItems:types shareParams:content sheetConfiguration:nil onStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
        //返回
        NSMutableDictionary *responseDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                             [NSNumber numberWithInteger:state],
                                             @"state",
                                             nil];
        if (error)
        {
            [responseDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                     [NSNumber numberWithInteger:[error code]],
                                     @"error_code",
                                     [error userInfo],
                                     @"error_msg",
                                     nil]
                             forKey:@"error"];
        }
        
        if ([contentEntity rawData])
        {
            [responseDict setObject:[contentEntity rawData] forKey:@"data"];
        }
        
        [context callbackWithRet:responseDict err:nil delete:YES];
        
        if (_refView)
        {
            [_refView removeFromSuperview];
        }
    }];
}



-(NSUInteger)_convertJSShareTypeToIOSShareType:(NSUInteger)JSShareType
{
    switch (JSShareType)
    {
        case 1:
            return SSDKContentTypeText;
        case 2:
        case 9:
            return SSDKContentTypeImage;
        case 4:
            return SSDKContentTypeWebPage;
        case 5:
            return SSDKContentTypeAudio;
        case 6:
            return SSDKContentTypeVideo;
        case 7:
            return SSDKContentTypeApp;
        case 0:
        case 8:
            return SSDKContentTypeAuto;
        case 10:
            return SSDKContentTypeMiniProgram;
        case 11:
            return SSDKContentTypeMessage;
        default:
            return SSDKContentTypeAuto;
            break;
    }
}

- (NSMutableDictionary *)_contentWithDict:(NSDictionary *)dict
{
    NSString *message = nil;
    NSURL *attachementUrl = nil;
    NSString *hashtag = nil;
    NSString *quote = nil;
    NSString *urlName = nil;
    NSString *title = nil;
    NSString *url = nil;
    NSString *desc = nil;
    NSString *quoteText = nil;
    
    id gif = nil;
    id audio = nil;
    id video = nil;
    id images = nil;

    SSDKContentType type = SSDKContentTypeAuto;
    BOOL clientShare = NO;
    BOOL advancedShare = NO;
    
    BOOL sina_linkCard = NO;
    NSString *sina_cardTitle = nil;
    NSString *sina_cardSummary = nil;
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    if (dict)
    {
        if ([[dict objectForKey:@"text"] isKindOfClass:[NSString class]])
        {
            message = [dict objectForKey:@"text"];
        }
        
        //Facebook相关
        if ([[dict objectForKey:@"urlName"] isKindOfClass:[NSString class]])
        {
            urlName = [dict objectForKey:@"urlName"];
        }
        
        if ([[dict objectForKey:@"attachementUrl"] isKindOfClass:[NSString class]])
        {
            attachementUrl = [NSURL URLWithString:[dict objectForKey:@"attachementUrl"]];
        }
        
        if ([[dict objectForKey:@"hashtag"] isKindOfClass:[NSString class]])
        {
            hashtag = [dict objectForKey:@"hashtag"];
        }
        
        if ([[dict objectForKey:@"quote"] isKindOfClass:[NSString class]])
        {
            quote = [dict objectForKey:@"quote"];
        }
        
        //Facebook相关
        
        if ([[dict objectForKey:@"title"] isKindOfClass:[NSString class]])
        {
            title = [dict objectForKey:@"title"];
        }
        
        if ([[dict objectForKey:@"titleUrl"] isKindOfClass:[NSString class]])
        {
            url = [dict objectForKey:@"titleUrl"];
        }
        
        if ([[dict objectForKey:@"description"] isKindOfClass:[NSString class]])
        {
            desc = [dict objectForKey:@"description"];
        }
        
        if ([dict objectForKey:@"gif"])
        {
            gif = [dict objectForKey:@"gif"];
        }
        
        if ([dict objectForKey:@"audio"])
        {
            audio = [dict objectForKey:@"audio"];
        }
        
        if ([dict objectForKey:@"video"])
        {
            video = [dict objectForKey:@"video"];
        }
        
        if ([dict objectForKey:@"images"])
        {
            images = [dict objectForKey:@"images"];
        }
        
        if ([[dict objectForKey:@"client_share"] isKindOfClass:[NSNumber class]])
        {
            clientShare = [[dict objectForKey:@"client_share"] boolValue];
        }
        
        if ([[dict objectForKey:@"advanced_share"] isKindOfClass:[NSNumber class]])
        {
            advancedShare = [[dict objectForKey:@"advanced_share"] boolValue];
        }
        
        if ([[dict objectForKey:@"type"] isKindOfClass:[NSNumber class]])
        {
            type = [self _convertJSShareTypeToIOSShareType:[[dict objectForKey:@"type"] unsignedIntegerValue]];
        }
        
        if ([[dict objectForKey:@"sina_linkCard"] isKindOfClass:[NSNumber class]] && [[dict objectForKey:@"sina_linkCard"] unsignedIntegerValue] > 0)
        {
            sina_linkCard = YES;
        }
        
        if ([[dict objectForKey:@"sina_cardTitle"] isKindOfClass:[NSString class]])
        {
            sina_cardTitle = [dict objectForKey:@"sina_cardTitle"];
        }
        
        if ([[dict objectForKey:@"sina_cardSummary"] isKindOfClass:[NSString class]])
        {
            sina_cardSummary = [dict objectForKey:@"sina_cardSummary"];
        }
        
    }
    [para SSDKSetupShareParamsByText:message
                              images:images
                                 url:[NSURL URLWithString:url]
                               title:title
                                type:type];
    
    //Facebook
    if ([dict objectForKey:@"FacebookShareType"])
    {
        id shareType = [dict objectForKey:@"FacebookShareType"];
        [para SSDKSetupFacebookParamsByText:message
                                      image:images
                                        url:[NSURL URLWithString:url]
                                   urlTitle:title
                                    urlName:urlName
                             attachementUrl:attachementUrl
                                    hashtag:hashtag
                                      quote:quote
                                  shareType:[shareType integerValue]
                                       type:type];
    }
    
    //Ins
    if ([dict objectForKey:@"insDisplayPointX"] && [dict objectForKey:@"insDisplayPointY"])
    {

        id displayPointX = [dict objectForKey:@"insDisplayPointX"];
        id displayPointY = [dict objectForKey:@"insDisplayPointY"];

        [para SSDKSetupInstagramByImage:images menuDisplayPoint:CGPointMake([displayPointX floatValue], [displayPointY floatValue])];
    }
    
    //WhatsApp
    if ([dict objectForKey:@"whatsAppDisplayPointX"] && [dict objectForKey:@"whatsAppDisplayPointY"])
    {
        id displayPointX = [dict objectForKey:@"whatsAppDisplayPointX"];
        id displayPointY = [dict objectForKey:@"whatsAppDisplayPointY"];

        [para SSDKSetupWhatsAppParamsByText:message
                                      image:images
                                      audio:(id)audio
                                      video:video
                           menuDisplayPoint:CGPointMake([displayPointX floatValue], [displayPointY floatValue])
                                       type:type];
    }
    
    //FacebookMessenger
    if ([[dict objectForKey:@"quoteText"] isKindOfClass:[NSString class]])
    {
        quoteText = [dict objectForKey:@"quoteText"];
        [para SSDKSetupFacebookMessengerParamsByTitle:title
                                                  url:[NSURL URLWithString: url]
                                            quoteText:quoteText
                                               images:images
                                                  gif:gif
                                                audio:audio
                                                video:video
                                                 type:type];
    }
    
    //sina
    if (sina_linkCard == YES)
    {
        [para setObject:@(sina_linkCard) forKey:@"sina_linkCard"];
        [para setObject:[MobSDK appKey] forKey:@"mob_appkey"];
        if (sina_cardTitle != nil)
        {
            [para setObject:sina_cardTitle forKey:@"sina_cardTitle"];
        }
        if (sina_cardSummary != nil)
        {
            [para setObject:sina_cardSummary forKey:@"sina_cardSummary"];
        }
    }
    
    if (dict)
    {
        NSString *siteUrlStr = nil;
        NSString *siteStr = nil;
        
        NSString *siteUrl = [dict objectForKey:@"siteUrl"];
        if ([siteUrl isKindOfClass:[NSString class]])
        {
            siteUrlStr = siteUrl;
        }
        
        NSString *site = [dict objectForKey:@"site"];
        if ([site isKindOfClass:[NSString class]])
        {
            siteStr = site;
        }
    }
    
    return para;
}

@end
