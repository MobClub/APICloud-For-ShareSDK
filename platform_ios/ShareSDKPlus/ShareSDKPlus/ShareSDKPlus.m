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
#import <WechatConnector/WeChatConnector.h>
#import <MOBFoundation/MobSDK+Privacy.h>
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
            [platformsRegister setupQQWithAppId:params[@"QQ_AppKey"] appkey:params[@"QQ_AppSecret"] enableUniversalLink:NO universalLink:params[@"QQ_AppUniversalLink"]];
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
        
        if (params[@"DingTalkAuth_AppKey"] && params[@"DingTalkAuth_AppSecret"] && params[@"DingTalkAuth_RedirectUri"])
        {
            [platformsRegister setupDingTalkAuthWithAppId:params[@"DingTalkAuth_AppKey"] appSecret:params[@"DingTalkAuth_AppSecret"] redirectUrl:params[@"DingTalkAuth_RedirectUri"]];
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
        
        if (params[@"Kakao_AppKey"] && params[@"Kakao_AppSecret"] && params[@"Kakao_RedirectUri"])
        {
            [platformsRegister setupKaKaoWithAppkey:params[@"Kakao_AppKey"] restApiKey:params[@"Kakao_AppSecret"] redirectUrl:params[@"Kakao_RedirectUri"]];
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
        
        if (params[@"TikTok_AppKey"] && params[@"TikTok_AppSecret"])
        {
            [platformsRegister setupTikTokByAppKey:params[@"TikTok_AppKey"] appSecret:params[@"TikTok_AppSecret"]];
        }
        
        if (params[@"KuaiShou_AppKey"] && params[@"KuaiShou_AppSecret"] && params[@"KuaiShou_AppUniversalLink"])
        {
            [platformsRegister setupKuaiShouWithAppId:params[@"KuaiShou_AppKey"] appSecret:params[@"KuaiShou_AppSecret"] universalLink:params[@"KuaiShou_AppUniversalLink"] delegate:[UZAppDelegate appDelegate]];
        }
        
        if (params[@"WeWork_Schema"] && params[@"WeWork_Appkey"] && params[@"WeWork_AgentId"] && params[@"WeWork_AppSecret"])
        {
            [platformsRegister setupWeWorkBySchema:params[@"WeWork_Schema"] appKey:params[@"WeWork_Appkey"] agentId:params[@"WeWork_AgentId"] appSecret:params[@"WeWork_AppSecret"]];
        }
        
        if (params[@"Oasis_AppKey"])
        {
            [platformsRegister setOasisByAppkey:params[@"Oasis_AppKey"]];
        }
        
        if (params[@"Snapchat_ClientId"] && params[@"Snapchat_ClientSecret"] && params[@"Snapchat_RedirectUrl"])
        {
            [platformsRegister setSnapChatClientId:params[@"Snapchat_ClientId"] clientSecret:params[@"Snapchat_ClientSecret"] redirectUrl:params[@"Snapchat_RedirectUrl"]];
        }
        
        
        // key.xml 读取
        UZAppDelegate *app = [UZAppDelegate appDelegate];
        if ([app securityValueForKey:@"shareSDKPlus_SinaWei_AppKey"] && [app securityValueForKey:@"shareSDKPlus_SinaWei_AppSecret"] && [app securityValueForKey:@"shareSDKPlus_SinaWei_RedirectUri"] && [app securityValueForKey:@"shareSDKPlus_SinaWei_AppUniversalLink"])
        {
            [platformsRegister setupSinaWeiboWithAppkey:[app securityValueForKey:@"shareSDKPlus_SinaWei_AppKey"] appSecret:[app securityValueForKey:@"shareSDKPlus_SinaWei_AppSecret"] redirectUrl:[app securityValueForKey:@"shareSDKPlus_SinaWei_RedirectUri"] universalLink:[app securityValueForKey:@"shareSDKPlus_SinaWei_AppUniversalLink"]];
        }
        
        if ([app securityValueForKey:@"shareSDKPlus_QQ_AppKey"] && [app securityValueForKey:@"shareSDKPlus_QQ_AppSecret"])
        {
            [platformsRegister setupQQWithAppId:[app securityValueForKey:@"shareSDKPlus_QQ_AppKey"] appkey:[app securityValueForKey:@"shareSDKPlus_QQ_AppSecret"]enableUniversalLink:NO universalLink:[app securityValueForKey:@"shareSDKPlus_QQ_AppUniversalLink"]];
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
        
        if (params[@"shareSDKPlus_DingTalkAuth_AppKey"] && params[@"shareSDKPlus_DingTalkAuth_AppSecret"] && params[@"shareSDKPlus_DingTalkAuth_RedirectUri"])
        {
            [platformsRegister setupDingTalkAuthWithAppId:params[@"shareSDKPlus_DingTalkAuth_AppKey"] appSecret:params[@"shareSDKPlus_DingTalkAuth_AppSecret"] redirectUrl:params[@"shareSDKPlus_DingTalkAuth_RedirectUri"]];
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
        
        if ([app securityValueForKey:@"shareSDKPlus_Kakao_AppKey"] && [app securityValueForKey:@"shareSDKPlus_Kakao_AppSecret"] && [app securityValueForKey:@"shareSDKPlus_Kakao_RedirectUri"])
        {
            [platformsRegister setupKaKaoWithAppkey:[app securityValueForKey:@"shareSDKPlus_Kakao_AppKey"] restApiKey:[app securityValueForKey:@"shareSDKPlus_Kakao_AppSecret"] redirectUrl:[app securityValueForKey:@"shareSDKPlus_Kakao_RedirectUri"]];
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
        
        if (params[@"shareSDKPlus_TikTok_AppKey"] && params[@"shareSDKPlus_TikTok_AppSecret"])
        {
            [platformsRegister setupTikTokByAppKey:params[@"shareSDKPlus_TikTok_AppKey"] appSecret:params[@"shareSDKPlus_TikTok_AppSecret"]];
        }
        
        if (params[@"shareSDKPlus_KuaiShou_AppKey"] && params[@"shareSDKPlus_KuaiShou_AppSecret"] && params[@"shareSDKPlus_KuaiShou_AppUniversalLink"])
        {
            [platformsRegister setupKuaiShouWithAppId:params[@"shareSDKPlus_KuaiShou_AppKey"] appSecret:params[@"shareSDKPlus_KuaiShou_AppSecret"] universalLink:params[@"shareSDKPlus_KuaiShou_AppUniversalLink"] delegate:[UZAppDelegate appDelegate]];
        }
        
        
        if (params[@"shareSDKPlus_WeWork_Schema"] && params[@"shareSDKPlus_WeWork_Appkey"] && params[@"shareSDKPlus_WeWork_AgentId"] && params[@"shareSDKPlus_WeWork_AppSecret"])
        {
            [platformsRegister setupWeWorkBySchema:params[@"shareSDKPlus_WeWork_Schema"] appKey:params[@"shareSDKPlus_WeWork_Appkey"] agentId:params[@"shareSDKPlus_WeWork_AgentId"] appSecret:params[@"shareSDKPlus_WeWork_AppSecret"]];
        }
        
        if (params[@"shareSDKPlus_Oasis_AppKey"])
        {
            [platformsRegister setOasisByAppkey:params[@"shareSDKPlus_Oasis_AppKey"]];
        }
        
        if (params[@"shareSDKPlus_Snapchat_ClientId"] && params[@"shareSDKPlus_Snapchat_ClientSecret"] && params[@"shareSDKPlus_Snapchat_RedirectUrl"])
        {
            [platformsRegister setSnapChatClientId:params[@"shareSDKPlus_Snapchat_ClientId"] clientSecret:params[@"shareSDKPlus_Snapchat_ClientSecret"] redirectUrl:params[@"shareSDKPlus_Snapchat_RedirectUrl"]];
        }
        
    }];
}
JS_METHOD(getPrivacyPolicy:(UZModuleMethodContext *)context)
{
    NSDictionary *params = context.param;
    BOOL isUrl = YES;
    if ([[params objectForKey:@"isUrl"] isKindOfClass:[NSNumber class]])
    {
        isUrl = [[params objectForKey:@"isUrl"] boolValue];
    }
    NSString *language = @"en-CN";
    if ([[params objectForKey:@"language"] isKindOfClass:[NSString class]])
    {
        language = [params objectForKey:@"language"];
    }
    [MobSDK getPrivacyPolicy:isUrl?@"1":@"2" language:language compeletion:^(NSDictionary * _Nullable data, NSError * _Nullable error) {
        //返回
        NSMutableDictionary *responseDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                             [NSNumber numberWithInteger:error?2:1],
                                             @"state",
                                             data?:@{},
                                             @"data",
                                             nil];
        if (error)
        {
            [responseDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                     [NSNumber numberWithInteger:2],
                                     @"error_code",
                                     [error userInfo],
                                     @"error_msg",
                                     nil]
                             forKey:@"error"];
        }
        
        [context callbackWithRet:responseDict err:nil delete:YES];

    }];
}
JS_METHOD(uploadPrivacyPermissionStatus:(UZModuleMethodContext *)context)
{
    NSDictionary *params = context.param;
    BOOL status = 0;
    if ([[params objectForKey:@"permissionStatus"] isKindOfClass:[NSNumber class]])
    {
        status = [[params objectForKey:@"permissionStatus"] boolValue];
    }
    [MobSDK uploadPrivacyPermissionStatus:status onResult:^(BOOL success) {
        //返回
        NSMutableDictionary *responseDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                             [NSNumber numberWithInteger:success?1:2],
                                             @"state",
                                             nil];
        if (!success)
        {
            [responseDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                     [NSNumber numberWithInteger:2],
                                     @"error_code",
                                     nil]
                             forKey:@"error"];
        }
        
        [context callbackWithRet:responseDict err:nil delete:YES];
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
    
    if ([[params objectForKey:@"shareParams"] isKindOfClass:[NSDictionary class]])
    {
        [self _contentWithDict:[params objectForKey:@"shareParams"] platforms:@[@(type)] completeHandle:^(NSMutableDictionary *content, BOOL complete) {
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
                if(state != 4){
                    //upload状态时不返回回调
                    [context callbackWithRet:responseDict err:nil delete:YES];
                }
             }];
        }];
    }
}

JS_METHOD(shareByActivityWithContent:(UZModuleMethodContext *)context)
{
    NSDictionary *params = context.param;
    
    SSDKPlatformType type = SSDKPlatformTypeAny;
    
    if ([[params objectForKey:@"platform"] isKindOfClass:[NSNumber class]])
    {
        type = [[params objectForKey:@"platform"] unsignedIntegerValue];
    }
    
    if ([[params objectForKey:@"shareParams"] isKindOfClass:[NSDictionary class]])
    {
        [self _contentWithDict:[params objectForKey:@"shareParams"] platforms:@[@(type)] completeHandle:^(NSMutableDictionary *content, BOOL complete) {
            if(complete){
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
        }];
    }
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
    
    if ([[params objectForKey:@"shareParams"] isKindOfClass:[NSDictionary class]])
    {
        [self _contentWithDict:[params objectForKey:@"shareParams"] platforms:types completeHandle:^(NSMutableDictionary *content, BOOL complete) {
            if(complete){
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
        }];
    }
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

- (void)_contentWithDict:(NSDictionary *)dict platforms:(NSArray *)platforms completeHandle:(void(^)(NSMutableDictionary *content,BOOL complete))completeHandle
{
    NSString *message = nil;
    NSURL *attachementUrl = nil;
    NSString *hashtag = nil;
    NSString *quote = nil;
    NSString *urlName = nil;
    NSString *title = nil;
    NSString *url = nil;
    NSString *desc = nil;
    NSString *musicFileURL = nil;
    NSString *extInfo = nil;
    NSString *sourceFileExtension = nil;
    NSString *fileData = nil;
    NSString *path = nil;
    NSString *userName = nil;
    NSString *extMsg = nil;
    NSDictionary *extDic = nil;
    NSString *audioFlashURL = nil;
    NSString *videoFlashURL = nil;
    NSString *miniAppID = nil;
    NSString *miniPath = nil;
    NSString *miniWebpageUrl = nil;
    NSString *templateId = nil;
    NSDictionary *templateArgs = nil;
    NSString *attachmentName = nil;
    NSString *attachmentType = nil;
    NSString *imageUrl = nil;
    NSString *boardName = nil;
    NSString *linkURL = nil;
    NSString *openID = nil;
    NSString *receiverOpenID = nil;
    NSString *localIdentifier = nil;
    NSArray *tags = nil;
    NSString *visibility = nil;
    NSString *audioName = nil;
    NSString *audioType = nil;
    NSString *videoName = nil;
    NSString *videoType = nil;
    NSString *fileName = nil;
    NSString *fileType = nil;
    int menuDisplayPointX = 0;
    int menuDisplayPointY = 0;
    NSString *musicLowBandUrl = nil;
    NSString *musicDataUrl = nil;
    NSString *musicLowBandDataUrl = nil;
    NSString *videoLowBandUrl = nil;
    NSString *comment = nil;
    NSString *toUserId = nil;
    NSString *caption = nil;
    NSString *attachmentUrl = nil;
    NSString *fileExtension = nil;

    
    
    
    int permission = 0;
    BOOL sharable = NO;
    NSDictionary *androidExecParam = nil;
    NSDictionary *iosExecParam = nil;
    
    
    BOOL withShareTicket = NO;
    BOOL shareToMini = NO;
    BOOL shareToQQMini = NO;
    BOOL openMini = NO;

    NSUInteger miniProgramType = 0;
   
    id assetLocalIds = nil;
    id imageAssets = nil;
    id videoAsset = nil;

    
    
    id gif = nil;
    id audio = nil;
    id video = nil;
    id images = nil;
    id emoticonData = nil;
    id thumbImage = nil;
    id hdThumbImage = nil;
    id sourceFileData = nil;
    id sticker = nil;
    BOOL stickerAnimated = NO;
    CGFloat stickerRotation = 0;
    NSInteger cameraViewState = 0;
    NSInteger shareActionMode = 0;

    
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
        
        if ([[dict objectForKey:@"url"] isKindOfClass:[NSString class]])
        {
            url = [dict objectForKey:@"url"];
        }
        
        if ([[dict objectForKey:@"description"] isKindOfClass:[NSString class]])
        {
            desc = [dict objectForKey:@"description"];
        }
        
        if ([dict objectForKey:@"gif"] && ![[dict objectForKey:@"gif"] isKindOfClass:[NSNull class]])
        {
            gif = [dict objectForKey:@"gif"];
        }
        
        if ([dict objectForKey:@"audio"] && ![[dict objectForKey:@"audio"] isKindOfClass:[NSNull class]])
        {
            audio = [dict objectForKey:@"audio"];
        }
        
        if ([dict objectForKey:@"video"] && ![[dict objectForKey:@"video"] isKindOfClass:[NSNull class]])
        {
            video = [dict objectForKey:@"video"];
        }
        
        if ([dict objectForKey:@"images"] && ![[dict objectForKey:@"images"] isKindOfClass:[NSNull class]])
        {
            images = [dict objectForKey:@"images"];
        }
        
        if ([dict objectForKey:@"audioName"])
        {
            audioName = [dict objectForKey:@"audioName"];
        }
        
        if ([dict objectForKey:@"audioType"])
        {
            audioType = [dict objectForKey:@"audioType"];
        }
        
        if ([dict objectForKey:@"videoName"])
        {
            videoName = [dict objectForKey:@"videoName"];
        }
        
        if ([dict objectForKey:@"videoType"])
        {
            videoType = [dict objectForKey:@"videoType"];
        }
        
        if ([dict objectForKey:@"fileName"])
        {
            fileName = [dict objectForKey:@"fileName"];
        }
        
        if ([dict objectForKey:@"fileType"])
        {
            fileType = [dict objectForKey:@"fileType"];
        }
        
        //wechat相关
        if ([dict objectForKey:@"emoticonData"] && ![[dict objectForKey:@"emoticonData"] isKindOfClass:[NSNull class]])
        {
            emoticonData = [dict objectForKey:@"emoticonData"];
        }
        
        if ([dict objectForKey:@"thumbImage"] && ![[dict objectForKey:@"thumbImage"] isKindOfClass:[NSNull class]])
        {
            thumbImage = [dict objectForKey:@"thumbImage"];
        }
        
        if ([dict objectForKey:@"musicFileURL"])
        {
            musicFileURL = [dict objectForKey:@"musicFileURL"];
        }
        
        if ([dict objectForKey:@"extInfo"])
        {
            extInfo = [dict objectForKey:@"extInfo"];
        }
        
        if ([[dict objectForKey:@"fileData"] isKindOfClass:[NSString class]])
        {
            fileData = [dict objectForKey:@"fileData"];
        }
        
        if ([dict objectForKey:@"sourceFileExtension"])
        {
            sourceFileExtension = [dict objectForKey:@"sourceFileExtension"];
        }
        
        if ([dict objectForKey:@"sourceFileData"] && ![[dict objectForKey:@"sourceFileData"] isKindOfClass:[NSNull class]])
        {
            sourceFileData = [dict objectForKey:@"sourceFileData"];
        }
        
        if ([[dict objectForKey:@"shareToMini"] isKindOfClass:[NSNumber class]])
        {
            shareToMini = [[dict objectForKey:@"shareToMini"] boolValue];
        }
        
        if ([dict objectForKey:@"path"])
        {
            path = [dict objectForKey:@"path"];
        }
        
        if ([dict objectForKey:@"userName"])
        {
            userName = [dict objectForKey:@"userName"];
        }
        
        if ([dict objectForKey:@"hdThumbImage"] && ![[dict objectForKey:@"hdThumbImage"] isKindOfClass:[NSNull class]])
        {
            hdThumbImage = [dict objectForKey:@"hdThumbImage"];
        }
        
        if ([[dict objectForKey:@"withShareTicket"] isKindOfClass:[NSNumber class]])
        {
            withShareTicket = [[dict objectForKey:@"withShareTicket"] boolValue];
        }
        
        if ([[dict objectForKey:@"miniProgramType"] isKindOfClass:[NSNumber class]])
        {
            miniProgramType = [[dict objectForKey:@"miniProgramType"] integerValue];
        }
        
        
        if ([[dict objectForKey:@"openMini"] isKindOfClass:[NSNumber class]])
        {
            openMini = [[dict objectForKey:@"openMini"] boolValue];
        }
        
        if ([dict objectForKey:@"extMsg"])
        {
            extMsg = [dict objectForKey:@"extMsg"];
        }
        
        if ([[dict objectForKey:@"extDic"] isKindOfClass:[NSDictionary class]])
        {
            extDic = [dict objectForKey:@"extDic"];
        }
        

        //QQ相关
        if ([dict objectForKey:@"audioFlashURL"])
        {
            audioFlashURL = [dict objectForKey:@"audioFlashURL"];
        }
        
        if ([dict objectForKey:@"videoFlashURL"])
        {
            videoFlashURL = [dict objectForKey:@"videoFlashURL"];
        }
        
        if ([[dict objectForKey:@"shareToQQMini"] isKindOfClass:[NSNumber class]])
        {
            shareToQQMini = [[dict objectForKey:@"shareToQQMini"] boolValue];
        }
        
        if ([dict objectForKey:@"miniAppID"])
        {
            miniAppID = [dict objectForKey:@"miniAppID"];
        }
        
        if ([dict objectForKey:@"miniPath"])
        {
            miniPath = [dict objectForKey:@"miniPath"];
        }
        
        if ([dict objectForKey:@"miniWebpageUrl"])
        {
            miniWebpageUrl = [dict objectForKey:@"miniWebpageUrl"];
        }
        
        //快手相关
        if ([dict objectForKey:@"linkURL"])
        {
            linkURL = [dict objectForKey:@"linkURL"];
        }
        if ([dict objectForKey:@"openID"])
        {
            openID = [dict objectForKey:@"openID"];
        }
        if ([dict objectForKey:@"receiverOpenID"])
        {
            receiverOpenID = [dict objectForKey:@"receiverOpenID"];
        }
        if ([dict objectForKey:@"localIdentifier"])
        {
            localIdentifier = [dict objectForKey:@"localIdentifier"];
        }
        if ([[dict objectForKey:@"tags"] isKindOfClass:[NSArray class]])
        {
            tags = [dict objectForKey:@"tags"];
        }
        
        
        //抖音、TikTok相关
        if ([[dict objectForKey:@"assetLocalIds"] isKindOfClass:[NSArray class]])
        {
            assetLocalIds = [dict objectForKey:@"assetLocalIds"];
        }
        if ([[dict objectForKey:@"shareActionMode"] isKindOfClass:[NSNumber class]])
        {
            shareActionMode = [[dict objectForKey:@"shareActionMode"] integerValue];
        }
        
        
        //Kakao相关
        if ([dict objectForKey:@"templateId"])
        {
            templateId = [dict objectForKey:@"templateId"];
        }
        
        if ([[dict objectForKey:@"templateArgs"] isKindOfClass:[NSDictionary class]])
        {
            templateArgs = [dict objectForKey:@"templateArgs"];
        }
        
        if ([[dict objectForKey:@"permission"] isKindOfClass:[NSNumber class]])
        {
            permission = [[dict objectForKey:@"permission"] intValue];
        }
        
        if ([[dict objectForKey:@"sharable"] isKindOfClass:[NSNumber class]])
        {
            sharable = [[dict objectForKey:@"sharable"] boolValue];
        }
        
        if ([[dict objectForKey:@"androidExecParam"] isKindOfClass:[NSDictionary class]])
        {
            androidExecParam = [dict objectForKey:@"androidExecParam"];
        }
        
        if ([[dict objectForKey:@"iosExecParam"] isKindOfClass:[NSDictionary class]])
        {
            iosExecParam = [dict objectForKey:@"iosExecParam"];
        }
        
        //Dropbox
        if ([dict objectForKey:@"attachmentName"])
        {
            attachmentName = [dict objectForKey:@"attachmentName"];
        }
        
        if ([dict objectForKey:@"attachmentType"])
        {
            attachmentType = [dict objectForKey:@"attachmentType"];
        }
        
        //Pinterest相关
        if ([dict objectForKey:@"imageUrl"])
        {
            imageUrl = [dict objectForKey:@"imageUrl"];
        }
        if ([dict objectForKey:@"boardName"])
        {
            boardName = [dict objectForKey:@"boardName"];
        }
        
        //LinkedIn相关
        if ([dict objectForKey:@"visibility"])
        {
            visibility = [dict objectForKey:@"visibility"];
        }
        
        //Telegram相关
        if ([[dict objectForKey:@"menuDisplayPointX"] isKindOfClass:[NSNumber class]])
        {
            menuDisplayPointX = [[dict objectForKey:@"menuDisplayPointX"] intValue];
        }
        
        if ([[dict objectForKey:@"menuDisplayPointY"] isKindOfClass:[NSNumber class]])
        {
            menuDisplayPointY = [[dict objectForKey:@"menuDisplayPointY"] intValue];
        }
        
        //有道
        if ([[dict objectForKey:@"imageAssets"] isKindOfClass:[NSArray class]])
        {
            imageAssets = [dict objectForKey:@"imageAssets"];
        }

        //明道
        if ([dict objectForKey:@"videoAsset"] && ![[dict objectForKey:@"videoAsset"] isKindOfClass:[NSNull class]])
        {
            videoAsset = [dict objectForKey:@"videoAsset"];
        }

        //易信
        if ([dict objectForKey:@"musicLowBandUrl"])
        {
            musicLowBandUrl = [dict objectForKey:@"musicLowBandUrl"];
        }

        if ([dict objectForKey:@"musicDataUrl"])
        {
            musicDataUrl = [dict objectForKey:@"musicDataUrl"];
        }

        if ([dict objectForKey:@"musicLowBandDataUrl"])
        {
            musicLowBandDataUrl = [dict objectForKey:@"musicLowBandDataUrl"];
        }

        if ([dict objectForKey:@"videoLowBandUrl"])
        {
            videoLowBandUrl = [dict objectForKey:@"videoLowBandUrl"];
        }

        if ([dict objectForKey:@"comment"])
        {
            comment = [dict objectForKey:@"comment"];
        }

        if ([dict objectForKey:@"toUserId"])
        {
            toUserId = [dict objectForKey:@"toUserId"];
        }
        
        //SnapChat相关
        if ([dict objectForKey:@"caption"])
        {
            caption = [dict objectForKey:@"caption"];
        }
        
        if ([dict objectForKey:@"attachmentUrl"])
        {
            attachmentUrl = [dict objectForKey:@"attachmentUrl"];
        }
        
        if ([dict objectForKey:@"sticker"]  && ![[dict objectForKey:@"sticker"] isKindOfClass:[NSNull class]])
        {
            sticker = [dict objectForKey:@"sticker"];
        }
        
        if ([[dict objectForKey:@"stickerAnimated"] isKindOfClass:[NSNumber class]])
        {
            stickerAnimated = [[dict objectForKey:@"stickerAnimated"] boolValue];
        }
        
        if ([[dict objectForKey:@"stickerRotation"] isKindOfClass:[NSNumber class]])
        {
            stickerRotation = [[dict objectForKey:@"stickerRotation"] floatValue];
        }
        
        if ([[dict objectForKey:@"cameraViewState"] isKindOfClass:[NSNumber class]])
        {
            cameraViewState = [[dict objectForKey:@"cameraViewState"] integerValue];
        }
        
        //Oasis相关
        if ([dict objectForKey:@"fileExtension"])
        {
            fileExtension = [dict objectForKey:@"fileExtension"];
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
    
    [para setValue:shareActionMode == 1 ? @(SSDKDouyinOpenSDKShareTypeShareContentToIM) : @(SSDKDouyinOpenSDKShareTypePublishMedia) forKey:SSDKDouYinShareActionKey];
    
    NSInteger currPlatform = [platforms[0] integerValue];
    
    //wechat
    if ([platforms containsObject:@(SSDKPlatformTypeWechat)] || [platforms containsObject:@(SSDKPlatformSubTypeWechatFav)] || [platforms containsObject:@(SSDKPlatformSubTypeWechatSession)] || [platforms containsObject:@(SSDKPlatformSubTypeWechatTimeline)]){
        if(shareToMini){
            [para SSDKSetupWeChatMiniProgramShareParamsByTitle:title
                                                         description:desc
                                                          webpageUrl:[NSURL URLWithString:url]
                                                                path:path
                                                          thumbImage:thumbImage
                                                        hdThumbImage:hdThumbImage
                                                            userName:userName
                                                     withShareTicket:withShareTicket
                                                     miniProgramType:miniProgramType
                                                  forPlatformSubType:currPlatform];
        }else if(openMini){
            // 应用打开小程序
            [WeChatConnector openMiniProgramWithUserName:userName
                                                    path:path
                                         miniProgramType:miniProgramType
                                                       extMsg:extMsg
                                                       extDic:extDic
                                                complete:^(BOOL success) {
                if (success)
                {
                    NSLog(@"打开小程序成功");
                }
                else
                {
                    NSLog(@"打开小程序失败");
                }
            }];
        }else{
            if(type == SSDKContentTypeAudio || type == SSDKContentTypeVideo ||
               type == SSDKContentTypeApp || type == SSDKContentTypeFile || emoticonData){
                
                [para SSDKSetupWeChatParamsByText:message
                                            title:title
                                              url:[NSURL URLWithString:url]
                                       thumbImage:thumbImage
                                            image:images
                                     musicFileURL:[NSURL URLWithString:musicFileURL]
                                          extInfo:extInfo
                                         fileData:[fileData dataUsingEncoding:NSUTF8StringEncoding]
                                     emoticonData:emoticonData
                              sourceFileExtension:sourceFileExtension
                                   sourceFileData:sourceFileData
                                             type:type
                               forPlatformSubType:currPlatform];
            }
        }
        
    }
    
    //QQ
    if ([platforms containsObject:@(SSDKPlatformTypeQQ)] || [platforms containsObject:@(SSDKPlatformSubTypeQQFriend)]){
        if(shareToQQMini){
            [para SSDKSetupQQMiniProgramShareParamsByTitle:title
                                               description:desc
                                                webpageUrl:[NSURL URLWithString:url]
                                              hdThumbImage:hdThumbImage
                                                 miniAppID:miniAppID
                                                  miniPath:miniPath
                                            miniWebpageUrl:miniWebpageUrl
                                           miniProgramType:miniProgramType
                                        forPlatformSubType:currPlatform];
        }else{
            [para SSDKSetupQQParamsByText:message
                                    title:title
                                      url:[NSURL URLWithString:url]
                            audioFlashURL:[NSURL URLWithString:audioFlashURL]
                            videoFlashURL:[NSURL URLWithString:videoFlashURL]
                               thumbImage:thumbImage
                                   images:images
                                     type:type
                       forPlatformSubType:currPlatform];
        }

    }

    //Facebook
    if ([platforms containsObject:@(SSDKPlatformTypeFacebook)])
    {
        int shareType = [[dict objectForKey:@"FacebookShareType"] intValue];
        [para SSDKSetupFacebookParamsByText:message
                                      image:images
                                        url:[NSURL URLWithString:url]
                                   urlTitle:title
                                    urlName:urlName
                             attachementUrl:attachementUrl
                                    hashtag:hashtag
                                      quote:quote
                                  shareType:shareType
                                       type:type];
    }
    
    //Ins
    if ([platforms containsObject:@(SSDKPlatformTypeInstagram)])
    {

        id displayPointX = [dict objectForKey:@"insDisplayPointX"];
        id displayPointY = [dict objectForKey:@"insDisplayPointY"];

        [para SSDKSetupInstagramByImage:images menuDisplayPoint:CGPointMake([displayPointX floatValue], [displayPointY floatValue])];
    }
    
    //WhatsApp
    if ([platforms containsObject:@(SSDKPlatformTypeWhatsApp)])
    {
        id displayPointX = [dict objectForKey:@"whatsAppDisplayPointX"];
        id displayPointY = [dict objectForKey:@"whatsAppDisplayPointY"];

        if(type == SSDKContentTypeImage){
            [para SSDKSetupWhatsAppParamsByText:message
                                          image:images
                                          audio:nil
                                          video:nil
                               menuDisplayPoint:CGPointMake([displayPointX floatValue], [displayPointY floatValue])
                                           type:type];
        }
    }
    
    //FacebookMessenger
    if ([platforms containsObject:@(SSDKPlatformTypeFacebookMessenger)])
    {
        [para SSDKSetupFacebookMessengerParamsByTitle:title
                                                  url:[NSURL URLWithString: url]
                                               images:images
                                                video:video
                                                 type:type];
    }
    
    //sina
    if ([platforms containsObject:@(SSDKPlatformTypeSinaWeibo)]){
        if (sina_linkCard == YES)
        {
            
            [para SSDKSetupSinaWeiboLinkCardShareParamsByText:message
                                                    cardTitle:sina_cardTitle
                                                  cardSummary:sina_cardSummary
                                                       images:images
                                                          url:[NSURL URLWithString: url]];
        }
        
        if(type == SSDKContentTypeVideo){
            [para SSDKSetupSinaWeiboShareParamsByText:message
                                                title:title
                                               images:nil
                                                video:[[NSBundle mainBundle]pathForResource:videoName ofType:videoType]
                                                  url:nil
                                             latitude:0
                                            longitude:0
                                             objectID:nil
                                       isShareToStory:NO
                                                 type:type];
        }
    }
    
    //快手
    if ([platforms containsObject:@(SSDKPlatformTypeKuaiShou)]){
        [para SSDKSetupKuaiShouShareParamsByTitle:title
                                             desc:desc
                                          linkURL:linkURL
                                       thumbImage:thumbImage
                                           openID:openID
                                   receiverOpenID:receiverOpenID
                                  localIdentifier:localIdentifier
                                             tags:tags
                                        extraInfo:extInfo
                                             type:SSDKContentTypeMessage];
    }
    
    //抖音
    if ([platforms containsObject:@(SSDKPlatformTypeDouyin)]){
        if(assetLocalIds){
            [para SSDKSetupDouyinParamesByAssetLocalIds:assetLocalIds
                                                hashtag:hashtag
                                              extraInfo:extDic
                                        shareActionMode:shareActionMode
                                                   type:type];
        }
    }
    
    //TikTok
    if ([platforms containsObject:@(SSDKPlatformTypeTikTok)]){
        if(assetLocalIds){
            [para SSDKSetupTikTokParamesByAssetLocalIds:assetLocalIds
                                                hashtag:hashtag
                                              extraInfo:extDic
                                                   type:type];
        }
    }
    
    //KakaoTalk
    if ([platforms containsObject:@(SSDKPlatformSubTypeKakaoTalk)]){
        [para SSDKSetupKaKaoTalkParamsByUrl:[NSURL URLWithString:url]
                                 templateId:templateId
                               templateArgs:templateArgs];

    }
    //KakaoStory
    if ([platforms containsObject:@(SSDKPlatformSubTypeKakaoStory)]){
        [para SSDKSetupKakaoStoryParamsByContent:message
                                           title:title
                                          images:images
                                             url:[NSURL URLWithString:url]
                                      permission:permission
                                        sharable:sharable
                                androidExecParam:androidExecParam
                                    iosExecParam:iosExecParam
                                            type:type];

    }
    //Dropbox
    if ([platforms containsObject:@(SSDKPlatformTypeDropbox)]){
        if(attachmentName && attachmentName.length && attachmentType && attachmentType.length ){
            [para SSDKSetupDropboxParamsByAttachment:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:attachmentName ofType:attachmentType]]];
        }
    }

    //Pinterest
    if ([platforms containsObject:@(SSDKPlatformTypePinterest)]){
        [para SSDKSetupPinterestParamsByImageUrl:imageUrl
                                                  desc:desc
                                                   url:[NSURL URLWithString:url]
                                             boardName:boardName];
    }
    
    //linkedin
    if ([platforms containsObject:@(SSDKPlatformTypeLinkedIn)]){
        [para SSDKSetupLinkedInParamsByText:message
                                            image:images
                                              url:[NSURL URLWithString:url]
                                            title:title
                                          urlDesc:desc
                                       visibility:visibility
                                             type:type];
    }

    //Telegram
    if ([platforms containsObject:@(SSDKPlatformTypeTelegram)]){
        if(type == SSDKContentTypeAudio || type == SSDKContentTypeVideo || type == SSDKContentTypeFile){
            [para SSDKSetupTelegramParamsByText:message
                                          image:images
                                          audio:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:audioName ofType:audioType]]
                                          video:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:audioName ofType:audioType]]
                                           file:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:fileName ofType:fileType]]
                               menuDisplayPoint:CGPointMake(menuDisplayPointX, menuDisplayPointY)
                                           type:type];
        }
    }
    
    //易信
    if ([platforms containsObject:@(SSDKPlatformSubTypeYiXinSession)] ||
        [platforms containsObject:@(SSDKPlatformSubTypeYiXinTimeline)] ||
        [platforms containsObject:@(SSDKPlatformSubTypeYiXinFav)]){

        if(type == SSDKContentTypeAudio || type == SSDKContentTypeVideo || type == SSDKContentTypeApp){
            [para SSDKSetupYiXinParamsByText:message
                                       title:title
                                         url:[NSURL URLWithString:url]
                                  thumbImage:thumbImage
                                       image:images
                                musicFileURL:[NSURL URLWithString:musicFileURL]
                             musicLowBandUrl:musicLowBandUrl
                                musicDataUrl:musicDataUrl
                         musicLowBandDataUrl:musicLowBandDataUrl
                                     extInfo:extInfo
                                    fileData:[fileData dataUsingEncoding:NSUTF8StringEncoding]
                             videoLowBandUrl:videoLowBandUrl
                                     comment:comment
                                    toUserId:toUserId
                                        type:type
                          forPlatformSubType:currPlatform];
        }
    }
    
    //SnapChat
    if ([platforms containsObject:@(SSDKPlatformTypeSnapChat)]){
        [para SSDKSetupSnapChatParamsByCaption:caption
                                 attachmentUrl:attachmentUrl
                                         image:images
                                         video:video
                                       sticker:sticker
                               stickerAnimated:stickerAnimated
                               stickerRotation:stickerRotation
                               cameraViewState:cameraViewState
                                          type:type];
    }
    //Oasis
    if ([platforms containsObject:@(SSDKPlatformTypeOasis)]){
        [para SSDKSetupOasisParamsByTitle:title
                                     text:message
                            assetLocalIds:assetLocalIds
                                    image:images
                                    video:video
                            fileExtension:fileExtension
                                     type:type];
    }
    
    //有道,明道
    if ([platforms containsObject:@(SSDKPlatformTypeYouDaoNote)] || [platforms containsObject:@(SSDKPlatformTypeMingDao)]){
        if(imageAssets || videoAsset){
            //有道不支持视频分享
            [para SSDKSetupShareParamsByImageAsset:imageAssets videoAsset:videoAsset completeHandle:^(BOOL complete) {
                if(complete){
                    completeHandle(para,YES);
                }
            }];
        }else{
            completeHandle(para,YES);
        }
    }else{
        completeHandle(para,YES);
    }
    
    
//    if (dict)
//    {
//        NSString *siteUrlStr = nil;
//        NSString *siteStr = nil;
//
//        NSString *siteUrl = [dict objectForKey:@"siteUrl"];
//        if ([siteUrl isKindOfClass:[NSString class]])
//        {
//            siteUrlStr = siteUrl;
//        }
//
//        NSString *site = [dict objectForKey:@"site"];
//        if ([site isKindOfClass:[NSString class]])
//        {
//            siteStr = site;
//        }
//    }
}

@end
