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

static NSString *const shareSDKModuleName = @"ShareSDKPlus";

@interface ShareSDKPlus ()

@property(nonatomic, strong)UIView *refView;

@end

@implementation ShareSDKPlus

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
        
        if (params[@"SinaWei_AppKey"] && params[@"SinaWei_AppSecret"] && params[@"SinaWei_RedirectUri"])
        {
            [platformsRegister setupSinaWeiboWithAppkey:params[@"SinaWei_AppKey"] appSecret:params[@"SinaWei_AppSecret"] redirectUrl:params[@"SinaWei_RedirectUri"]];
        }
        
        if (params[@"QQ_AppKey"] && params[@"QQ_AppSecret"])
        {
            [platformsRegister setupQQWithAppId:params[@"QQ_AppKey"] appkey:params[@"QQ_AppSecret"]];
        }
        
        if (params[@"Wechat_AppKey"] && params[@"Wechat_AppSecret"])
        {
            [platformsRegister setupWeChatWithAppId:params[@"Wechat_AppKey"] appSecret:params[@"Wechat_AppSecret"]];
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
        
        if (params[@"MeiPai_AppKey"])
        {
            [platformsRegister setupMeiPaiWithAppkey:params[@"MeiPai_AppKey"]];
        }
        
        if (params[@"DingTalk_AppKey"])
        {
            [platformsRegister setupDingTalkWithAppId:params[@"DingTalk_AppKey"]];
        }
        
        if (params[@"DouBan_AppKey"] && params[@"DouBan_AppSecret"] && params[@"DouBan_RedirectUri"])
        {
            [platformsRegister setupDouBanWithApikey:params[@"DouBan_AppKey"] appSecret:params[@"DouBan_AppSecret"] redirectUrl:params[@"DouBan_RedirectUri"]];
        }
        
        if (params[@"TencentWeibo_AppKey"] && params[@"TencentWeibo_AppSecret"] && params[@"TencentWeibo_RedirectUri"])
        {
            [platformsRegister setupTencentWeiboWithAppkey:params[@"TencentWeibo_AppKey"] appSecret:params[@"TencentWeibo_AppSecret"] redirectUrl:params[@"TencentWeibo_RedirectUri"]];
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
        
        if (params[@"Renren_AppId"] && params[@"Renren_AppKey"] && params[@"Renren_AppSecret"])
        {
            [platformsRegister setupRenRenWithAppId:params[@"Renren_AppId"] appKey:params[@"Renren_AppKey"] secretKey:params[@"Renren_AppSecret"] authType:params[@"Renren_AuthType"]?[params[@"Renren_AuthType"] integerValue]:2];
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

        if (params[@"CMCC_AppId"] && params[@"CMCC_AppKey"])
        {
            [platformsRegister setupCMCCByAppId:params[@"CMCC_AppId"] appKey:params[@"CMCC_AppKey"] displayUI:params[@"CMCC_DisplayUI"]?[params[@"CMCC_DisplayUI"] integerValue]:YES];
        }
        
        if (params[@"Telegram_BotToken"] && params[@"Telegram_BotDomain"])
        {
            [platformsRegister setupTelegramByBotToken:params[@"Telegram_BotToken"] botDomain:params[@"Telegram_BotDomain"]];
        }
        
        if (params[@"Reddit_AppKey"] && params[@"Reddit_RedirectUri"])
        {
            [platformsRegister setupRedditByAppKey:params[@"Reddit_AppKey"] redirectUri:params[@"Reddit_RedirectUri"]];
        }
        
        if (params[@"ESurfing_AppKey"] && params[@"ESurfing_AppSecret"] && params[@"ESurfing_AppName"])
        {
            [platformsRegister setupESurfingByAppKey:params[@"ESurfing_AppKey"] appSecret:params[@"ESurfing_AppSecret"] appName:params[@"ESurfing_AppName"]];
        }
        
        
        
        
        // key.xml 读取
        UZAppDelegate *app = [UZAppDelegate appDelegate];
        if ([app securityValueForKey:@"ShareSDKPlus_SinaWei_AppKey"] && [app securityValueForKey:@"ShareSDKPlus_SinaWei_AppSecret"] && [app securityValueForKey:@"ShareSDKPlus_SinaWei_RedirectUri"])
        {
            [platformsRegister setupSinaWeiboWithAppkey:[app securityValueForKey:@"ShareSDKPlus_SinaWei_AppKey"] appSecret:[app securityValueForKey:@"ShareSDKPlus_SinaWei_AppSecret"] redirectUrl:[app securityValueForKey:@"ShareSDKPlus_SinaWei_RedirectUri"]];
        }
        
        if ([app securityValueForKey:@"ShareSDKPlus_QQ_AppKey"] && [app securityValueForKey:@"ShareSDKPlus_QQ_AppSecret"])
        {
            [platformsRegister setupQQWithAppId:[app securityValueForKey:@"ShareSDKPlus_QQ_AppKey"] appkey:[app securityValueForKey:@"ShareSDKPlus_QQ_AppSecret"]];
        }
        
        if ([app securityValueForKey:@"ShareSDKPlus_Wechat_AppKey"] && [app securityValueForKey:@"ShareSDKPlus_Wechat_AppSecret"])
        {
            [platformsRegister setupWeChatWithAppId:[app securityValueForKey:@"ShareSDKPlus_Wechat_AppKey"] appSecret:[app securityValueForKey:@"ShareSDKPlus_Wechat_AppSecret"]];
        }
        
        if ([app securityValueForKey:@"ShareSDKPlus_Douyin_AppKey"] && [app securityValueForKey:@"ShareSDKPlus_Douyin_AppSecret"])
        {
            [platformsRegister setupDouyinByAppKey:[app securityValueForKey:@"ShareSDKPlus_Douyin_AppKey"] appSecret:[app securityValueForKey:@"ShareSDKPlus_Douyin_AppSecret"]];
        }
        
        if ([app securityValueForKey:@"ShareSDKPlus_Facebook_AppKey"] && [app securityValueForKey:@"ShareSDKPlus_Facebook_AppSecret"] && [app securityValueForKey:@"ShareSDKPlus_Facebook_DisplayName"])
        {
            [platformsRegister setupFacebookWithAppkey:[app securityValueForKey:@"ShareSDKPlus_Facebook_AppKey"] appSecret:[app securityValueForKey:@"ShareSDKPlus_Facebook_AppSecret"] displayName:[app securityValueForKey:@"ShareSDKPlus_Facebook_DisplayName"]];
        }
        
        if ([app securityValueForKey:@"ShareSDKPlus_Twitter_AppKey"] && [app securityValueForKey:@"ShareSDKPlus_Twitter_AppSecret"] && [app securityValueForKey:@"ShareSDKPlus_Twitter_RedirectUri"])
        {
            [platformsRegister setupTwitterWithKey:[app securityValueForKey:@"ShareSDKPlus_Twitter_AppKey"] secret:[app securityValueForKey:@"ShareSDKPlus_Twitter_AppSecret"] redirectUrl:[app securityValueForKey:@"ShareSDKPlus_Twitter_RedirectUri"]];
        }
        
        if ([app securityValueForKey:@"ShareSDKPlus_AliPaySocial_AppKey"])
        {
            [platformsRegister setupAliSocialWithAppId:[app securityValueForKey:@"ShareSDKPlus_AliPaySocial_AppKey"]];
        }
        
        if ([app securityValueForKey:@"ShareSDKPlus_MeiPai_AppKey"])
        {
            [platformsRegister setupMeiPaiWithAppkey:[app securityValueForKey:@"ShareSDKPlus_MeiPai_AppKey"]];
        }
        
        if ([app securityValueForKey:@"ShareSDKPlus_DingTalk_AppKey"])
        {
            [platformsRegister setupDingTalkWithAppId:[app securityValueForKey:@"ShareSDKPlus_DingTalk_AppKey"]];
        }
        
        if ([app securityValueForKey:@"ShareSDKPlus_DouBan_AppKey"] && [app securityValueForKey:@"ShareSDKPlus_DouBan_AppSecret"] && [app securityValueForKey:@"ShareSDKPlus_DouBan_RedirectUri"])
        {
            [platformsRegister setupDouBanWithApikey:[app securityValueForKey:@"ShareSDKPlus_DouBan_AppKey"] appSecret:[app securityValueForKey:@"ShareSDKPlus_DouBan_AppSecret"] redirectUrl:[app securityValueForKey:@"ShareSDKPlus_DouBan_RedirectUri"]];
        }
        
        if ([app securityValueForKey:@"ShareSDKPlus_TencentWeibo_AppKey"] && [app securityValueForKey:@"ShareSDKPlus_TencentWeibo_AppSecret"] && [app securityValueForKey:@"ShareSDKPlus_TencentWeibo_RedirectUri"])
        {
            [platformsRegister setupTencentWeiboWithAppkey:[app securityValueForKey:@"ShareSDKPlus_TencentWeibo_AppKey"] appSecret:[app securityValueForKey:@"ShareSDKPlus_TencentWeibo_AppSecret"] redirectUrl:[app securityValueForKey:@"ShareSDKPlus_TencentWeibo_RedirectUri"]];
        }
        
        if ([app securityValueForKey:@"ShareSDKPlus_YinXiang_AppKey"] && [app securityValueForKey:@"ShareSDKPlus_YinXiang_AppSecret"])
        {
            [platformsRegister setupEvernoteByConsumerKey:[app securityValueForKey:@"ShareSDKPlus_YinXiang_AppKey"] consumerSecret:[app securityValueForKey:@"ShareSDKPlus_YinXiang_AppSecret"] sandbox:[app securityValueForKey:@"ShareSDKPlus_YinXiang_Sandbox"]?[[app securityValueForKey:@"ShareSDKPlus_YinXiang_Sandbox"] integerValue]:1];
        }
        
        if ([app securityValueForKey:@"ShareSDKPlus_YouDaoNote_AppKey"] && [app securityValueForKey:@"ShareSDKPlus_YouDaoNote_AppSecret"] && [app securityValueForKey:@"ShareSDKPlus_YouDaoNote_RedirectUri"])
        {
            [platformsRegister setupYouDaoNoteWithConsumerKey:[app securityValueForKey:@"ShareSDKPlus_YouDaoNote_AppKey"] consumerSecret:[app securityValueForKey:@"ShareSDKPlus_YouDaoNote_AppSecret"] oauthCallback:[app securityValueForKey:@"ShareSDKPlus_YouDaoNote_RedirectUri"]];
        }
        
        if ([app securityValueForKey:@"ShareSDKPlus_Mingdao_AppKey"] && [app securityValueForKey:@"ShareSDKPlus_Mingdao_AppSecret"] && [app securityValueForKey:@"ShareSDKPlus_Mingdao_RedirectUri"])
        {
            [platformsRegister setupMingDaoByAppKey:[app securityValueForKey:@"ShareSDKPlus_Mingdao_AppKey"] appSecret:[app securityValueForKey:@"ShareSDKPlus_Mingdao_AppSecret"] redirectUrl:[app securityValueForKey:@"ShareSDKPlus_Mingdao_RedirectUri"]];
        }
        
        if ([app securityValueForKey:@"ShareSDKPlus_Kaixin_AppKey"] && [app securityValueForKey:@"ShareSDKPlus_Kaixin_AppSecret"] && [app securityValueForKey:@"ShareSDKPlus_Kaixin_RedirectUri"])
        {
            [platformsRegister setupKaiXinByApiKey:[app securityValueForKey:@"ShareSDKPlus_Kaixin_AppKey"] secretKey:[app securityValueForKey:@"ShareSDKPlus_Kaixin_AppSecret"] redirectUrl:[app securityValueForKey:@"ShareSDKPlus_Kaixin_RedirectUri"]];
        }
        
        if ([app securityValueForKey:@"ShareSDKPlus_Renren_AppId"] && [app securityValueForKey:@"ShareSDKPlus_Renren_AppKey"] && [app securityValueForKey:@"ShareSDKPlus_Renren_AppSecret"])
        {
            [platformsRegister setupRenRenWithAppId:[app securityValueForKey:@"ShareSDKPlus_Renren_AppId"] appKey:[app securityValueForKey:@"ShareSDKPlus_Renren_AppKey"] secretKey:[app securityValueForKey:@"ShareSDKPlus_Renren_AppSecret"] authType:[app securityValueForKey:@"ShareSDKPlus_Renren_AuthType"]?[[app securityValueForKey:@"ShareSDKPlus_Renren_AuthType"] integerValue]:2];
        }
        
        if ([app securityValueForKey:@"ShareSDKPlus_YiXin_AppKey"] && [app securityValueForKey:@"ShareSDKPlus_YiXin_AppSecret"] && [app securityValueForKey:@"ShareSDKPlus_YiXin_RedirectUri"])
        {
            [platformsRegister setupYiXinByAppId:[app securityValueForKey:@"ShareSDKPlus_YiXin_AppKey"] appSecret:[app securityValueForKey:@"ShareSDKPlus_YiXin_AppSecret"] redirectUrl:[app securityValueForKey:@"ShareSDKPlus_YiXin_RedirectUri"]];
        }
        
        if ([app securityValueForKey:@"ShareSDKPlus_Instagram_AppKey"] && [app securityValueForKey:@"ShareSDKPlus_Instagram_AppSecret"] && [app securityValueForKey:@"ShareSDKPlus_Instagram_RedirectUri"])
        {
            [platformsRegister setupInstagramWithClientId:[app securityValueForKey:@"ShareSDKPlus_Instagram_AppKey"] clientSecret:[app securityValueForKey:@"ShareSDKPlus_Instagram_AppSecret"] redirectUrl:[app securityValueForKey:@"ShareSDKPlus_Instagram_RedirectUri"]];
        }
        
        [platformsRegister setupLineAuthType:[app securityValueForKey:@"ShareSDKPlus_Line_AuthType"]?[[app securityValueForKey:@"ShareSDKPlus_Line_AuthType"] integerValue]:2];
        
        
        if ([app securityValueForKey:@"ShareSDKPlus_Google_AppKey"] && [app securityValueForKey:@"ShareSDKPlus_Google_AppSecret"] && [app securityValueForKey:@"ShareSDKPlus_Google_RedirectUri"])
        {
            [platformsRegister setupGooglePlusByClientID:[app securityValueForKey:@"ShareSDKPlus_Google_AppKey"] clientSecret:[app securityValueForKey:@"ShareSDKPlus_Google_AppSecret"] redirectUrl:[app securityValueForKey:@"ShareSDKPlus_Google_RedirectUri"]];
        }
        
        if ([app securityValueForKey:@"ShareSDKPlus_Kakao_AppKey"] && [app securityValueForKey:@"ShareSDKPlus_Kakao_ApiKey"] && [app securityValueForKey:@"ShareSDKPlus_Kakao_RedirectUri"])
        {
            [platformsRegister setupKaKaoWithAppkey:[app securityValueForKey:@"ShareSDKPlus_Kakao_AppKey"] restApiKey:[app securityValueForKey:@"ShareSDKPlus_Kakao_ApiKey"] redirectUrl:[app securityValueForKey:@"ShareSDKPlus_Kakao_RedirectUri"]];
        }
        
        if ([app securityValueForKey:@"ShareSDKPlus_YouTube_AppKey"] && [app securityValueForKey:@"ShareSDKPlus_YouTube_AppSecret"] && [app securityValueForKey:@"ShareSDKPlus_YouTube_RedirectUri"])
        {
            [platformsRegister setupYouTubeWithClientId:[app securityValueForKey:@"ShareSDKPlus_YouTube_AppKey"] clientSecret:[app securityValueForKey:@"ShareSDKPlus_YouTube_AppSecret"] redirectUrl:[app securityValueForKey:@"ShareSDKPlus_YouTube_RedirectUri"]];
        }
        
        if ([app securityValueForKey:@"ShareSDKPlus_Flickr_AppKey"] && [app securityValueForKey:@"ShareSDKPlus_Flickr_AppSecret"])
        {
            [platformsRegister setupFlickrWithApiKey:[app securityValueForKey:@"ShareSDKPlus_Flickr_AppKey"] apiSecret:[app securityValueForKey:@"ShareSDKPlus_Flickr_AppSecret"]];
        }
        
        if ([app securityValueForKey:@"ShareSDKPlus_Dropbox_AppKey"] && [app securityValueForKey:@"ShareSDKPlus_Dropbox_AppSecret"] && [app securityValueForKey:@"ShareSDKPlus_Dropbox_RedirectUri"])
        {
            [platformsRegister setupDropboxWithAppKey:[app securityValueForKey:@"ShareSDKPlus_Dropbox_AppKey"] appSecret:[app securityValueForKey:@"ShareSDKPlus_Dropbox_AppSecret"] redirectUrl:[app securityValueForKey:@"ShareSDKPlus_Dropbox_RedirectUri"]];
        }
        
        if ([app securityValueForKey:@"ShareSDKPlus_Evernote_AppKey"] && [app securityValueForKey:@"ShareSDKPlus_Evernote_AppSecret"])
        {
            [platformsRegister setupEvernoteByConsumerKey:[app securityValueForKey:@"ShareSDKPlus_Evernote_AppKey"] consumerSecret:[app securityValueForKey:@"ShareSDKPlus_Evernote_AppSecret"] sandbox:[app securityValueForKey:@"ShareSDKPlus_Evernote_Sandbox"]?[[app securityValueForKey:@"ShareSDKPlus_Evernote_Sandbox"] integerValue]:1];
        }
        
        if ([app securityValueForKey:@"ShareSDKPlus_Pinterest_AppKey"])
        {
            [platformsRegister setupPinterestByClientId:[app securityValueForKey:@"ShareSDKPlus_Pinterest_AppKey"]];
        }
        
        if ([app securityValueForKey:@"ShareSDKPlus_Pocket_AppKey"] && [app securityValueForKey:@"ShareSDKPlus_Pocket_RedirectUri"])
        {
            [platformsRegister setupPocketWithConsumerKey:[app securityValueForKey:@"ShareSDKPlus_Pocket_AppKey"] redirectUrl:[app securityValueForKey:@"ShareSDKPlus_Pocket_RedirectUri"]];
        }
        
        if ([app securityValueForKey:@"ShareSDKPlus_LinkedIn_AppKey"] && [app securityValueForKey:@"ShareSDKPlus_LinkedIn_AppSecret"] && [app securityValueForKey:@"ShareSDKPlus_LinkedIn_RedirectUri"])
        {
            [platformsRegister setupLinkedInByApiKey:[app securityValueForKey:@"ShareSDKPlus_LinkedIn_AppKey"] secretKey:[app securityValueForKey:@"ShareSDKPlus_LinkedIn_AppSecret"] redirectUrl:[app securityValueForKey:@"ShareSDKPlus_LinkedIn_RedirectUri"]];
        }
        
        if ([app securityValueForKey:@"ShareSDKPlus_VKontakte_AppKey"] && [app securityValueForKey:@"ShareSDKPlus_VKontakte_AppSecret"])
        {
            [platformsRegister setupVKontakteWithApplicationId:[app securityValueForKey:@"ShareSDKPlus_VKontakte_AppKey"] secretKey:[app securityValueForKey:@"ShareSDKPlus_VKontakte_AppSecret"] authType:[app securityValueForKey:@"ShareSDKPlus_VKontakte_AuthType"]?[[app securityValueForKey:@"ShareSDKPlus_VKontakte_AuthType"] integerValue]:2];
        }
        
        if ([app securityValueForKey:@"ShareSDKPlus_Instapaper_AppKey"] && [app securityValueForKey:@"ShareSDKPlus_Instapaper_AppSecret"])
        {
            [platformsRegister setupInstapaperWithConsumerKey:[app securityValueForKey:@"ShareSDKPlus_Instapaper_AppKey"] consumerSecret:[app securityValueForKey:@"ShareSDKPlus_Instapaper_AppSecret"]];
        }
        
        if ([app securityValueForKey:@"ShareSDKPlus_Tumblr_AppKey"] && [app securityValueForKey:@"ShareSDKPlus_Tumblr_AppSecret"] && [app securityValueForKey:@"ShareSDKPlus_Tumblr_RedirectUri"])
        {
            [platformsRegister setupTumblrByConsumerKey:[app securityValueForKey:@"ShareSDKPlus_Tumblr_AppKey"] consumerSecret:[app securityValueForKey:@"ShareSDKPlus_Tumblr_AppSecret"] redirectUrl:[app securityValueForKey:@"ShareSDKPlus_Tumblr_RedirectUri"]];
        }
        
        [platformsRegister setupSMSOpenCountryList:[app securityValueForKey:@"ShareSDKPlus_SMS_CountryList"]?[[app securityValueForKey:@"ShareSDKPlus_SMS_CountryList"] integerValue]:0];
        
        if ([app securityValueForKey:@"ShareSDKPlus_CMCC_AppId"] && [app securityValueForKey:@"ShareSDKPlus_CMCC_AppKey"])
        {
            [platformsRegister setupCMCCByAppId:[app securityValueForKey:@"ShareSDKPlus_CMCC_AppId"] appKey:[app securityValueForKey:@"ShareSDKPlus_CMCC_AppKey"] displayUI:[app securityValueForKey:@"ShareSDKPlus_CMCC_DisplayUI"]?[[app securityValueForKey:@"ShareSDKPlus_CMCC_DisplayUI"] integerValue]:YES];
        }
        
        if ([app securityValueForKey:@"ShareSDKPlus_Telegram_BotToken"] && [app securityValueForKey:@"ShareSDKPlus_Telegram_BotDomain"])
        {
            [platformsRegister setupTelegramByBotToken:[app securityValueForKey:@"ShareSDKPlus_Telegram_BotToken"] botDomain:[app securityValueForKey:@"ShareSDKPlus_Telegram_BotDomain"]];
        }
        
        if ([app securityValueForKey:@"ShareSDKPlus_Reddit_AppKey"] && [app securityValueForKey:@"ShareSDKPlus_Reddit_RedirectUri"])
        {
            [platformsRegister setupRedditByAppKey:[app securityValueForKey:@"ShareSDKPlus_Reddit_AppKey"] redirectUri:[app securityValueForKey:@"ShareSDKPlus_Reddit_RedirectUri"]];
        }
        
        if ([app securityValueForKey:@"ShareSDKPlus_ESurfing_AppKey"] && [app securityValueForKey:@"ShareSDKPlus_ESurfing_AppSecret"] && [app securityValueForKey:@"ShareSDKPlus_ESurfing_AppName"])
        {
            [platformsRegister setupESurfingByAppKey:[app securityValueForKey:@"ShareSDKPlus_ESurfing_AppKey"] appSecret:[app securityValueForKey:@"ShareSDKPlus_ESurfing_AppSecret"] appName:[app securityValueForKey:@"ShareSDKPlus_ESurfing_AppName"]];
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
    
    UIViewController *vc = [MOBFViewController currentViewController];
    if ([MOBFDevice isPad])
    {
        if (!_refView)
        {
            _refView = [[UIView alloc] initWithFrame:CGRectMake(x, y, 1, 1)];
        }
        else
        {
            _refView.frame = CGRectMake(x, y, 1, 1);
        }
        
        [vc.view addSubview:_refView];
    }
    
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
        default:
            return SSDKContentTypeAuto;
            break;
    }
}

- (NSMutableDictionary *)_contentWithDict:(NSDictionary *)dict
{
    NSString *message = nil;
    id image = nil;
    NSString *title = nil;
    NSString *url = nil;
    NSString *desc = nil;
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
        
        if ([dict objectForKey:@"imageUrl"])
        {
            image = [dict objectForKey:@"imageUrl"];
        }
        
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
                              images:image
                                 url:[NSURL URLWithString:url]
                               title:title
                                type:type];
    
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
